#!/usr/bin/env python3
#
# Douglas P. Fields, Jr. - Written by Antigravity 2026-06-17
#
# check_parens.py - Parentheses Balance Validator for Lisp Source Files
#
# This script scans Lisp source files (.lisp and .asd) to verify that all
# opening and closing parentheses are balanced. It correctly handles Lisp-specific
# syntax, including:
# - Character literals (e.g. #\Space, #\Semicolon, #\()
# - Single-line semicolon comments
# - Multi-line nested block comments (#| ... |#)
# - String literals (with escaped characters)
#
# Usage:
#   python3 check_parens.py <file1> <file2> ...
#
# Exit Codes:
#   0 - All files have fully balanced parentheses.
#   1 - One or more files have unbalanced parentheses or file errors.

import sys

def check_parentheses(filepath):
    """
    Checks the parentheses balance of a single file, ignoring comments,
    strings, and character literals.
    """
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading file '{filepath}': {e}", file=sys.stderr)
        return False

    stack = []
    line_num = 1
    col_num = 1

    i = 0
    n = len(content)
    errors = 0

    while i < n:
        char = content[i]

        if char == '\n':
            line_num += 1
            col_num = 1
            i += 1
            continue

        # Skip character literals starting with #\
        if char == '#' and i + 1 < n and content[i+1] == '\\':
            i += 2
            # Read character name or single character
            if i < n:
                if content[i].isalnum():
                    while i < n and content[i].isalnum():
                        i += 1
                else:
                    i += 1
            continue

        # Skip single-line comments (only if not preceded by #\)
        if char == ';':
            while i < n and content[i] != '\n':
                i += 1
            continue

        # Skip nested block comments (#| ... |#)
        if char == '#' and i + 1 < n and content[i+1] == '|':
            i += 2
            nest = 1
            while i + 1 < n and nest > 0:
                if content[i] == '#' and content[i+1] == '|':
                    nest += 1
                    i += 2
                elif content[i] == '|' and content[i+1] == '#':
                    nest -= 1
                    i += 2
                else:
                    if content[i] == '\n':
                        line_num += 1
                    i += 1
            continue

        # Skip string literals
        if char == '"':
            i += 1
            escaped = False
            while i < n:
                if escaped:
                    escaped = False
                elif content[i] == '\\':
                    escaped = True
                elif content[i] == '"':
                    i += 1
                    break
                if content[i] == '\n':
                    line_num += 1
                i += 1
            col_num += 1
            continue

        # Track opening and closing parentheses
        if char == '(':
            stack.append((line_num, col_num))
        elif char == ')':
            if not stack:
                print(f"ERROR: Extra closing parenthesis at {filepath}:{line_num}:{col_num}", file=sys.stderr)
                errors += 1
            else:
                stack.pop()

        i += 1
        col_num += 1

    # Report any unclosed opening parentheses
    for open_line, open_col in stack:
        print(f"ERROR: Unclosed opening parenthesis at {filepath}:{open_line}:{open_col}", file=sys.stderr)
        errors += 1

    if errors == 0:
        print(f"SUCCESS: Parentheses in '{filepath}' are fully balanced!")
        return True
    else:
        print(f"FAILED: Found {errors} parentheses mismatch(es) in '{filepath}'.", file=sys.stderr)
        return False

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python3 check_parens.py <file1> [file2 ...]", file=sys.stderr)
        sys.exit(1)

    all_success = True
    for filepath in sys.argv[1:]:
        success = check_parentheses(filepath)
        if not success:
            all_success = False

    sys.exit(0 if all_success else 1)
