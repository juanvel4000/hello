# contributing to hello

hello is maintained on [sourcehut](https://sr.ht/~juanvel400/hello) -- this document explains how to report bugs and send patches there.

## reporting bugs / requesting features

use the [ticket tracker](https://todo.sr.ht/~juanvel400/hello). when filing a bug include

- your OS and hello version (`hello -V`)
- steps to reproduce
- what you expected vs. what happened

## sending patches

hello doesn't use GitHub-style pull requests. instead:

1. clone the repo and make your changes on a branch
2. commit with a clear, scoped message (see "commit style" below)
3. configure `git send-email` if you haven't already -- see
[sr.ht's send-email tutorial](https://git-send-email.io/)
4. send your patch to: **~juanvel400/hello-devel@lists.sr.ht**
```sh
 $ git send-email --to=~juanvel400/hello-devel@lists.sr.ht origin/main..HEAD
```

## commit style

- one logical change per commit
- imperative, lowercase summary line (`add X`, not `Added X` or `adds X`) -- matches the existing log
- keep the summary under ~72 chars; use the body for anything that needs more explanation

## before submitting

- make sure `make all` completes with no warnings
- run `make check`

## code style

- ANSI C89 compliant code; avoid GNUisms
- run `clang-format` to format the C code
```sh
clang-format -i src/*.c
```
## license

by contributing, you agree your changes are licensed under BSD-3-Clause, matching the rest of the project (see LICENSE).
