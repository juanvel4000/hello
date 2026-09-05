.DEFAULT_GOAL := all

SRCS := src/hello.c
TARGET := hello

PREFIX ?= /usr/local
DESTDIR ?=
BINDIR ?= /bin

INSTALL_TARGET := $(DESTDIR)$(PREFIX)$(BINDIR)

VERSION = $(shell git describe --tags --abbrev=0 2>/dev/null || echo "0.1.1")
CC ?= cc
CFLAGS ?= -std=c89 -Wall -Wextra -Werror -DVERSION=\"$(VERSION)\"

TAR ?= tar
RM ?= rm

DISTDIR = hello-$(VERSION)
DISTFILE = $(DISTDIR).tar.xz

$(TARGET): $(SRCS)
	$(CC) $(SRCS) -o $(TARGET) $(CFLAGS)

install:
	install -Dm755 $(TARGET) $(INSTALL_TARGET)/$(TARGET)

clean:
	rm -f $(TARGET)

all: $(TARGET)

check: $(TARGET)
	./$(TARGET) | grep -q "Hello"

dist:
	@echo " MKDIR $(DISTDIR)"
	@mkdir -p $(DISTDIR)
	@echo " CP Makefile LICENSE src"
	@cp -r Makefile LICENSE src $(DISTDIR)/
	@echo " TAR $(DISTFILE)"
	@$(TAR) -cJf $(DISTFILE) $(DISTDIR)
	@echo " RM $(DISTDIR)"
	@$(RM) -rf $(DISTDIR)
	@echo " SHA256 $(DISTFILE).sha256"
	@sha256sum $(DISTFILE) > $(DISTFILE).sha256


.PHONY: dist all check install clean
