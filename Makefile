# Generated automatically from Makefile.in by configure.
INSTALL ?= /usr/bin/install -c
SHELL ?= /bin/sh
PERL ?= /usr/bin/perl
prefix ?= /home/danielt/unix
exec_prefix = ${prefix}
bindir = ${exec_prefix}/bin
mandir = ${prefix}/man
sysconfdir = ${prefix}/etc

yasql yasql.1 : YASQL-VERSION-FILE
	${PERL} ./config.pl ${PERL} ${bindir} ${mandir} \
		${sysconfdir} "${YASQL_VERSION}"

YASQL-VERSION-FILE:
	${SHELL} ./YASQL-VERSION-GEN
-include YASQL-VERSION-FILE

default: yasql yasql.1

install : default
	${PERL} ./install.pl "${INSTALL}" ${bindir} ${mandir} ${sysconfdir}

check : default
	./yasql --help > /dev/null

clean :
	/bin/rm -f yasql yasql.1 YASQL-VERSION-FILE

distclean : clean
	/bin/rm -f Makefile
