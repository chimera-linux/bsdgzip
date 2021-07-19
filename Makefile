CC      ?= cc
CFLAGS  ?= -O2
PREFIX  ?= /usr/local
BINDIR  ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share
MANDIR  ?= $(DATADIR)/man/man1
PKG_CONFIG ?= pkg-config
EXTRA_CFLAGS = -std=c99 -D_GNU_SOURCE -Wall -Wextra -Wno-implicit-fallthrough -I. -Dlint `$(PKG_CONFIG) --cflags liblzma`
EXTRA_LDFLAGS = -lz -lbz2 -lfts `$(PKG_CONFIG) --libs liblzma`

OBJS = gzip.o

PROGRAM = gzip

.PHONY: clean

all: $(PROGRAM)

.c.o:
	$(CC) -c -o $@ $< $(EXTRA_CFLAGS) $(CFLAGS)

$(PROGRAM): $(OBJS)
	$(CC) $(EXTRA_CFLAGS) $(CFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS) $(OBJS) -o $(PROGRAM)

clean:
	rm -f $(OBJS) $(PROGRAM)

install:
	# binary and manual page
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(PROGRAM) $(DESTDIR)$(BINDIR)/$(PROGRAM)
	install -d $(DESTDIR)$(MANDIR)
	install -m 644 $(PROGRAM).1 $(DESTDIR)$(MANDIR)/$(PROGRAM).1
	# program sylinks
	ln -sf $(PROGRAM) $(DESTDIR)$(BINDIR)/gunzip
	ln -sf $(PROGRAM) $(DESTDIR)$(BINDIR)/gzcat
	ln -sf $(PROGRAM) $(DESTDIR)$(BINDIR)/zcat
	ln -sf $(PROGRAM).1 $(DESTDIR)$(MANDIR)/gunzip.1
	ln -sf $(PROGRAM).1 $(DESTDIR)$(MANDIR)/gzcat.1
	ln -sf $(PROGRAM).1 $(DESTDIR)$(MANDIR)/zcat.1
	# scripts
	install -m 755 gzexe $(DESTDIR)$(BINDIR)/gzexe
	install -m 755 zdiff $(DESTDIR)$(BINDIR)/zdiff
	install -m 755 zforce $(DESTDIR)$(BINDIR)/zforce
	install -m 755 zmore $(DESTDIR)$(BINDIR)/zmore
	install -m 755 znew $(DESTDIR)$(BINDIR)/znew
	install -m 755 gzexe.1 $(DESTDIR)$(MANDIR)/gzexe.1
	install -m 755 zdiff.1 $(DESTDIR)$(MANDIR)/zdiff.1
	install -m 755 zforce.1 $(DESTDIR)$(MANDIR)/zforce.1
	install -m 755 zmore.1 $(DESTDIR)$(MANDIR)/zmore.1
	install -m 755 znew.1 $(DESTDIR)$(MANDIR)/znew.1
	# script symlinks
	ln -sf zdiff $(DESTDIR)$(BINDIR)/zcmp
	ln -sf zdiff $(DESTDIR)$(BINDIR)/xzdiff
	ln -sf zmore $(DESTDIR)$(BINDIR)/zless
	ln -sf zdiff.1 $(DESTDIR)$(MANDIR)/zcmp.1
	ln -sf zdiff.1 $(DESTDIR)$(MANDIR)/xzdiff.1
	ln -sf zmore.1 $(DESTDIR)$(MANDIR)/zless.1

gzip.o: unbzip2.c zuncompress.c unpack.c unxz.c unlz.c
