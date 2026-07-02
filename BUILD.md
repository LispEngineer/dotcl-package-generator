# DotCL Package Generator Build Notes

* Author: [Douglas P. Fields, Jr.](mailto:symbolics@lisp.engineer)
* Copyright 2026 Douglas P. Fields, Jr.


# Version Numbers

When changing the code, the version number needs to be updated in
these locations:

* [`Makefile`](Makefile)
* [`assembly-package-generator.lisp`](assembly-package-generator.lisp)
* [`dotcl-packagegen.asd`](dotcl-packagegen.asd)
* [`RELEASES.md`](RELEASES.md)


# Parentheses Balance Checker

[`check_parens.py`](check_parens.py) 
(forked from my [dotcl-dungeonslime](https://github.com/LispEngineer/dotcl-dungeonslime)) 
scans Lisp source files and verifies that every opening parenthesis has a matching
closing one, correctly skipping character literals (`#\(`), single-line `;`
comments, nested `#| ... |#` block comments, and string literals. It exits
`0` if every file it's given is balanced, `1` otherwise.

* `make check-parens` — runs it over every `.lisp`/`.asd` file in the
  repository (excluding `bin/`, `obj/`, `.git/`, and `nupkg/`). Run this
  after hand-editing any Lisp source file.

* `make test` also runs it automatically, but on **generated** output rather
  than source: as part of the test run, `test` uses the freshly built
  executable to generate a couple of representative standard-.NET packages
  end-to-end (`System.TimeSpan` and `System.Console`, into
  `obj/test-generated/`) and then runs `check_parens.py` on those generated
  `.lisp` files. This is a regression check on the generator's own
  code-emission logic — since packages are produced via textual templating
  (`format` strings in `assembly-package-generator.lisp`), a bug there can
  silently emit Lisp with mismatched parentheses that unit tests alone
  wouldn't catch.

To check a specific file (or a freshly generated one) directly:

```sh
python3 check_parens.py path/to/file.lisp [path/to/another.lisp ...]
```
