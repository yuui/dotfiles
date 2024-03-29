# -*- coding: utf-8; -*-
# Emacs Makefile for TRAMP
# Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1998-2012 Free Software Foundation, Inc.

# Author: Kai Großjohann <kai.grossjohann@gmx.net>
#         Michael Albinus <michael.albinus@gmx.de>
# Keywords: comm, processes

# This file is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

# This Makefile requires GNU make and GNU tar.

# N.B.  Configuration of utilities for XEmacs packages is done in
# ../../Local.rules.  These have no effect on XEmacs's package build
# process (and thus live inside the conditional).


EMACS		= emacs
EMACS_INFO	= emacs
MAKEINFO	= makeinfo
RM		= -rm -f
AUTOCONF	= autoconf

DESTDIR		=
DIRS		= lisp texi

CONFIG_FILES	= Makefile contrib/Makefile lisp/Makefile lisp/trampver.el texi/Makefile texi/trampver.texi
CLEAN_FILES	= .\\\#* \\\#* .*~ *~ *.aux *.cp *.cps *.diff *.dvi *.elc *.fn *.fns *.html *.info *.ky *.log *.pg *.tmp *.toc *.tp *.vr *.vrs

# To be used by maintainer only.
VERSION		= $(subst .,-,2.2.4)
TARNAME		= tramp-2.2.4
EMACS_TARGET	= ../emacs
XEMACS_TARGET	= ../xemacs/packages/xemacs-packages/tramp

# Can't use wildcard tramp-*.el since that would catch tramp-efs.el,
# too, which isn't included in Emacs.
# lisp/trampver.el is not listed here since it is a generated file,
# but the files listed here are subjected to "cvs diff".  We just copy
# lisp/trampver.el.
EMACS_EL_FILES = lisp/tramp.el lisp/tramp-cache.el lisp/tramp-cmds.el	\
		lisp/tramp-compat.el lisp/tramp-ftp.el			\
		lisp/tramp-gvfs.el lisp/tramp-gw.el lisp/tramp-smb.el	\
		lisp/tramp-uu.el

# texi/trampver.texi is not listed here since it is a generated file,
# but the files listed here are subjected to "cvs diff".  We just copy
# texi/trampver.texi.
EMACS_TEXI_FILES = texi/tramp.texi

# XEmacs Tramp package has the same filesystem structure as Tramp
# itself.  Furthermore, it doesn't take *.el and *.texi only.  So one
# target is sufficient.  ChangeLog is copied to ChangeLog.upstream,
# lisp/trampver.el and texi/trampver.texi are copied, too.
XEMACS_FILES = CONTRIBUTORS						\
		lisp/ChangeLog lisp/tramp-cache.el lisp/tramp-cmds.el	\
		lisp/tramp-compat.el lisp/tramp-efs.el			\
		lisp/tramp-smb.el lisp/tramp-util.el lisp/tramp-uu.el	\
		lisp/tramp-vc.el lisp/tramp.el				\
		test/test-harness.el test/tramp-expr.el			\
		test/tramp-file-name.eltest/tramp-path.el texi/ChangeLog\
		texi/tramp.texi texi/doclicense.texi

TRAMP_EMACS_MERGE_VERSION = 2.2.3-24.1
TRAMP_EMACS_MERGE_TAG = $(subst .,-,V-2.2.3-24.1)

# ftp upload program to be used.
ifeq (no, yes)
  # Michaels flavor.
  FTP_UPLOAD = ftp-upload --host ftp-upload.gnu.org \
			  --dir /incoming/ftp
else
  # Kais flavor.
  FTP_UPLOAD = ftp -u ftp://ftp-upload.gnu.org/incoming/ftp
endif

# Decrease noise.
.SILENT: all lisp info install clean

.PHONY: all install lisp info clean distclean tags	\
	maintainer-clean cvstag MANIFEST tar emacs	\
	xemacs savannah cvs-update

all install: $(CONFIG_FILES)
	for a in ${DIRS}; do				\
	    $(MAKE) -C $$a				\
	    "EMACS=$(EMACS)" "EMACS_INFO=$(EMACS_INFO)"	\
	    "DESTDIR=$(DESTDIR)" $(MAKECMDGOALS);	\
	done

lisp: $(CONFIG_FILES)
	$(MAKE) -C lisp					\
	    "EMACS=$(EMACS)" "EMACS_INFO=$(EMACS_INFO)"	\
	    "DESTDIR=$(DESTDIR)" all

info: $(CONFIG_FILES)
	$(MAKE) -C texi					\
	    "EMACS=$(EMACS)" "EMACS_INFO=$(EMACS_INFO)"	\
	    "DESTDIR=$(DESTDIR)" all

clean:
	$(RM) $(CLEAN_FILES)				\
	      $(addprefix test/, $(CLEAN_FILES))
	for a in ${DIRS} contrib; do			\
	    $(MAKE) -C $$a clean;			\
	done

distclean: clean
	for a in ${DIRS} contrib; do			\
	    $(MAKE) -C $$a distclean;			\
	done
	$(RM) $(CONFIG_FILES) MANIFEST *.tar.gz*
	$(RM) -r autom4te.cache info

tags:
	etags lisp/*.el texi/*.texi

# Maintainer targets.

maintainer-clean: distclean
	$(RM) configure config.status

cvstag:
	cvs tag -F V-$(VERSION)

# Depends on configure in order to run autoconf.  All files
# which shall be produced on customer host should be removed.
MANIFEST: configure distclean
	find . \( -name CVS    -prune \)		\
	    -o \( -name info   -prune \)		\
	    -o \( -name tmp    -prune \)		\
	    -o \( -name tramp2 -prune \)		\
	    -o \( -type f \!   -name *,v		\
			  \!   -name .cvsignore \)	\
	    -print > MANIFEST
	./config.status

tar: MANIFEST
	mkdir $(TARNAME)
	tar cpfT - MANIFEST | ( cd $(TARNAME) ; tar xpf - )
	chmod -R a+r $(TARNAME)
	tar cvpfz $(TARNAME).tar.gz $(TARNAME)
	$(RM) -r $(TARNAME)
	gpg --detach-sign $(TARNAME).tar.gz
	echo "version: 1.1\ndirectory: tramp\nfilename: $(TARNAME).tar.gz"   \
		>$(TARNAME).tar.gz.directive
	gpg --clearsign $(TARNAME).tar.gz.directive
	$(RM) $(TARNAME).tar.gz.directive
	chmod a+r $(TARNAME).tar.gz*

emacs:
	./configure --with-contrib --with-packaging --with-emacs;	     \
	cvs -f diff -u -r$(TRAMP_EMACS_MERGE_TAG) -rV-$(VERSION)	     \
		$(EMACS_EL_FILES) > tramp-emacs-merge.diff || true;	     \
	( cd $(EMACS_TARGET)/lisp/net; patch -p1 ) < tramp-emacs-merge.diff; \
	cp lisp/trampver.el $(EMACS_TARGET)/lisp/net;			     \
	cvs -f diff -u -r$(TRAMP_EMACS_MERGE_TAG) -rV-$(VERSION)	     \
		$(EMACS_TEXI_FILES) > tramp-emacs-merge2.diff || true;	     \
	( cd $(EMACS_TARGET)/man; patch -p1 ) < tramp-emacs-merge2.diff;     \
	cp texi/trampver.texi $(EMACS_TARGET)/man;			     \
	ls $(EMACS_TARGET)/lisp/net/*.rej >/dev/null 2>/dev/null &&	     \
		echo "WARNING!  Patch in lisp/net didn't apply cleanly.";    \
	ls $(EMACS_TARGET)/man/*.rej >/dev/null 2>/dev/null &&		     \
		echo "WARNING!  Patch in man didn't apply cleanly.";	     \
	echo "Don't forget to update the ChangeLog for Emacs.";		     \
	echo "Also remember to update Emacs merge revision in configure.ac."

xemacs:
	./configure --with-contrib --with-packaging --with-xemacs;	     \
	cvs -f diff -u -r$(TRAMP_EMACS_MERGE_TAG) -rV-$(VERSION)	     \
		$(XEMACS_FILES) > tramp-xemacs-merge.diff || true;	     \
	patch -p0 -d $(XEMACS_TARGET) < tramp-xemacs-merge.diff;	     \
	find $(XEMACS_TARGET) -name "*.rej" >/dev/null 2>/dev/null &&	     \
		echo "WARNING!  Patch didn't apply cleanly.";		     \
	cp lisp/trampver.el $(XEMACS_TARGET)/lisp;			     \
	cp texi/trampver.texi $(XEMACS_TARGET)/texi;			     \
	cp ChangeLog $(XEMACS_TARGET)/ChangeLog.upstream;		     \
	echo "Don't forget to update AUTHOR_VERSION in Makefile.";	     \
	echo "Don't forget to update the ChangeLog for XEmacs.";	     \
	echo "Announce patch in xemacs-patches mailing list.";		     \
	echo "Also remember to update Emacs merge revision in configure.ac."

savannah: tar cvstag
	$(FTP_UPLOAD) $(TARNAME).tar.gz*
	./configure
	$(MAKE) -C texi savannah

cvs-update:
	cvs update -dP

# Targets updating files generated by autoconf and configure.

$(CONFIG_FILES): $(CONFIG_FILES:=.in) config.status
	./config.status

config.status: configure
	./config.status --recheck

configure: aclocal.m4 configure.ac
	$(AUTOCONF)

# Experimental stuff.

# Make "Version foo released." ChangeLog entries.
cl-release:
	for cl in ChangeLog */ChangeLog; do \
	    emacs -nw $$cl --eval \
	    "(progn (add-change-log-entry nil nil nil t) \
	    (backward-delete-char 2) \
	    (insert \"Version 2.2.4 released.\") \
	    (save-buffer) (kill-emacs))" ; \
	done
