#!/usr/bin/bash
#
# revert-cspackages-timestamps.sh
#
# Douglas P. Fields, Jr. - symbolics@lisp.engineer
#
# Every file dotcl-packagegen emits into cspackages/ embeds the moment it was
# generated in two places:
#   ;;; Creation Date: 2026-07-02T21:04:57Z
#   (cl:defconstant <creation> "2026-07-02T21:04:57Z")
# so re-running `make cspackages` touches every file's git diff even when the
# generator produced byte-identical output otherwise. This script inspects
# each modified file under cspackages/ and, if the *only* lines that differ
# from HEAD are those two timestamp lines, reverts the file with
# `git checkout --`. Files with any other change are left as-is for review.
#
# Usage: ./revert-cspackages-timestamps.sh [--dry-run]
#   --dry-run  Report what would be reverted without touching any files.

set -euo pipefail

DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=1
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

CSPACKAGES_DIR="cspackages-test"

# Matches the +/- diff lines for the two timestamp fields emitted by the
# generator. Escaped parenthesis for the defconstant form.
TIMESTAMP_LINE_RE='^[+-];;; Creation Date:|^[+-]\(cl:defconstant <creation>|^[+-]Generation date:'

reverted=0
kept=0
unchanged=0

while IFS= read -r -d '' file; do
  diff_output="$(git diff -- "$file")"

  # Everything the diff added or removed, minus the "--- a/..."/"+++ b/..."
  # file-header lines and the two known timestamp lines.
  real_changes="$(printf '%s\n' "$diff_output" \
    | grep -E '^[+-]' \
    | grep -vE '^--- |^\+\+\+ ' \
    | grep -vE "$TIMESTAMP_LINE_RE" \
    || true)"

  if [ -z "$diff_output" ]; then
    unchanged=$((unchanged + 1))
  elif [ -z "$real_changes" ]; then
    if [ "$DRY_RUN" -eq 1 ]; then
      echo "Would revert (timestamp-only): $file"
    else
      echo "Reverting (timestamp-only):    $file"
      # .git/index.lock can be held momentarily by an editor's background git
      # polling (e.g. VS Code's Git extension refreshing status every few
      # seconds); retry briefly instead of aborting the whole run.
      attempt=0
      until git checkout -- "$file"; do
        attempt=$((attempt + 1))
        if [ "$attempt" -ge 10 ]; then
          echo "error: could not check out $file after $attempt attempts (persistent lock?)" >&2
          exit 1
        fi
        sleep 0.3
      done
    fi
    reverted=$((reverted + 1))
  else
    echo "Keeping (real changes):         $file"
    kept=$((kept + 1))
  fi
done < <(git diff --name-only -z -- "$CSPACKAGES_DIR")

echo
if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run: would revert $reverted timestamp-only file(s), keep $kept file(s) with real changes ($unchanged already unchanged)."
else
  echo "Reverted $reverted timestamp-only file(s), kept $kept file(s) with real changes ($unchanged already unchanged)."
fi
