CFLAGS += -g
LDFLAGS += -lX11 -lXfixes

PREFIX=/usr/local
DESTDIR=

INSTDIR=$(DESTDIR)$(PREFIX)
INSTBIN=$(INSTDIR)/bin

all: xcinfo

xcinfo.o: xcinfo.c

install:
	test -d $(INSTDIR) || mkdir -p $(INSTDIR)
	test -d $(INSTBIN) || mkdir -p $(INSTBIN)

	install -m 0755 xcinfo $(INSTBIN)

uninstall:
	rm -f $(INSTBIN)/xcinfo

clean:
	rm -f xcinfo xcinfo.o

.PHONY: all install uninstall clean
