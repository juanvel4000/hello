.DEFAULT_GOAL := all

SRCS := src/hello.c
TARGET := hello

MANPAGE := doc/man/hello.1
MANPAGE_TARGET := hello.1.gz

PREFIX ?= /usr/local
DESTDIR ?=
BINDIR ?= /bin
MANDIR ?= /share/man/man1

INSTALL_TARGET := $(DESTDIR)$(PREFIX)$(BINDIR)
INSTALL_DOC_TARGET := $(DESTDIR)$(PREFIX)$(MANDIR)

VERSION = $(shell git describe --tags --abbrev=0 2>/dev/null || echo "0.1.2")
CC ?= cc
CFLAGS ?= -std=c89 -Wall -Wextra -Werror -DVERSION=\"$(VERSION)\"

TAR ?= tar
RM ?= rm
GZIP ?= gzip

DISTDIR = hello-$(VERSION)
DISTFILE = $(DISTDIR).tar.xz

$(TARGET): $(SRCS)
	@echo " CC $(TARGET)"
	@$(CC) $(SRCS) -o $(TARGET) $(CFLAGS)

$(MANPAGE_TARGET): $(MANPAGE)
	@echo " GZIP $(MANPAGE_TARGET)"
	@$(GZIP) -kc $(MANPAGE) > $(MANPAGE_TARGET)

install: all
	@echo " INSTALL $(INSTALL_TARGET)/$(TARGET)"
	@install -Dm755 $(TARGET) $(INSTALL_TARGET)/$(TARGET)
	@echo " INSTALL $(INSTALL_DOC_TARGET)/$(MANPAGE_TARGET)"
	@install -Dm644 $(MANPAGE_TARGET) $(INSTALL_DOC_TARGET)/$(MANPAGE_TARGET)

clean:
	@echo " RM $(TARGET)"
	@rm -f $(TARGET)
	@echo " RM $(MANPAGE_TARGET)"
	@rm -f $(MANPAGE_TARGET)

all: $(TARGET) $(MANPAGE_TARGET)

check: $(TARGET)
	./$(TARGET) | grep -q "Hello, World!"
	./$(TARGET) -n "Bob" | grep -q "Hello, Bob!"
	./$(TARGET) -V | grep -q "hello $(VERSION)"

dist: clean
	@echo " MKDIR $(DISTDIR)"
	@mkdir -p $(DISTDIR)
	@echo " CP Makefile LICENSE src doc"
	@cp -r Makefile LICENSE src doc $(DISTDIR)/
	@echo " TAR $(DISTFILE)"
	@$(TAR) -cJf $(DISTFILE) $(DISTDIR)
	@echo " RM $(DISTDIR)"
	@$(RM) -rf $(DISTDIR)
	@echo " SHA256 $(DISTFILE).sha256"
	@sha256sum $(DISTFILE) > $(DISTFILE).sha256


.PHONY: dist all check install clean
