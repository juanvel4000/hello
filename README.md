# hello

simple hello world program written in C.

## features

- name choosing (`-n`)
- ANSI C89 compliant
- extremely lightweight
- manual page (`hello(1)`)

## building

compile with `make`

```sh
make
```

### testing

run the simple test suite
```sh
make check
```

### installation

install with `make`
```sh
make install
```

> use the `DESTDIR`, `BINDIR`, `MANDIR`, and `PREFIX` variables to configure the installation paths for hello.
### dependencies

- GNU `make`
- C compiler (preferably `gcc`)
- POSIX libc

## project status

hello is in active development. it is functional and moving toward stability, though some interfaces might still change before a 1.0 release.

- [CHANGELOG.md](CHANGELOG.md) -- release history
- [CONTRIBUTING.md](CONTRIBUTING.md) -- how to report bugs and send patches

## license

BSD-3-Clause, see [LICENSE](LICENSE)
