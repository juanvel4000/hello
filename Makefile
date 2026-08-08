.DEFAULT_GOAL := all

SRCS := src/hello.c
TARGET := hello

PREFIX ?= /usr/local
DESTDIR ?=
BINDIR ?= /bin

INSTALL_TARGET := $(DESTDIR)$(PREFIX)$(BINDIR)

CC ?= cc
CFLAGS ?= -std=c89 -Wall -Wextra -Werror

TAR ?= tar
RM ?= rm

DISTDIR = hello-0.1.0
DISTFILE = $(DISTDIR).tar.xz

$(TARGET): $(SRCS)
	$(CC) $(SRCS) -o $(TARGET) $(CFLAGS)

install:
	install -dm755 $(TARGET) $(INSTALL_TARGET)/$(TARGET)

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
