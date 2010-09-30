##*****************************************************************************
##
##    DESCRIPTION: Verilog parser Makefile
##
##*****************************************************************************
##
## Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
## redistribute it and/or modify it under the terms of either the GNU
## General Public License or the Perl Artistic License.
##
## This code is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
##*****************************************************************************
## Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
##*****************************************************************************

TARGET = vparser
#YACC = menhir
YACC = ocamlyacc -v
#LEXOPTS = -ml
#YACCOPTS = --trace

CMO = ord.cmo setup.cmo lexer.cmo globals.cmo grammar.cmo dump.cmo semantics.cmo parse.cmo main.cmo
CML = str.cma # extLib.cma

vtop: $(TARGET)
	ocamlmktop -g -o vtop $(CML) $(CMO)

$(TARGET): $(CMO)
	ocamlc.opt -g -o $@ $(CML) $(CMO)

depend: grammar.ml lexer.ml
	ocamldep *.ml *.mli > .depend

clean:
	rm -rf *.cmi *.cmo vtop $(TARGET)
	rm -rf grammar.ml grammar.mli lexer.ml lexer.mli grammar.mli grammar.ml ord.ml

.SUFFIXES: .ml .mli .mll .mly .cmo .cmi

.ml.cmo:
	ocamlc.opt -g -c $<

.mli.cmi:
	ocamlc.opt -g -c $<

.mll.ml:
	ocamllex.opt $(LEXOPTS) $<

grammar.mli grammar.ml: grammar.mly
	$(YACC) $(YACCOPTS) $<
	mv -f grammar.mli{,.old}
	sed 's=\(> \)\(token\)=\1Vparser.\2=' < grammar.mli.old > grammar.mli

ord.ml: ord.sh grammar.cmi
	sh ord.sh

vparser.cmi: grammar.mli
	cat $< | grep -v : | grep -v \> >vparser.mli
	ocamlc.opt -g -c vparser.mli

test: vtop
	ocamldebug ./vparser

debug: vtop
	ocamldebug ./vtop

include .depend
