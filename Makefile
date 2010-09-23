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
YACC = menhir
#LEXOPTS = -ml
#YACCOPTS = --trace

CMO = ord.cmo setup.cmo lexer.cmo globals.cmo grammar.cmo dump.cmo semantics.cmo parse.cmo main.cmo
CML = str.cma extLib.cma

vtop: $(TARGET)
	ocamlmktop -g -o vtop $(CML) $(CMO)

$(TARGET): $(CMO)
	ocamlc -g -o $@ $(CML) $(CMO)

depend: grammar.ml lexer.ml
	ocamldep *.ml *.mli > .depend

clean:
	rm -rf *.cmi *.cmo vtop $(TARGET)
	rm -rf grammar.ml grammar.mli lexer.ml lexer.mli vparser.mli vparser.ml ord.ml

.SUFFIXES: .ml .mli .mll .mly .cmo .cmi

.ml.cmo:
	ocamlc -g -c $<

.mli.cmi:
	ocamlc -g -c $<

.mll.ml:
	ocamllex $(LEXOPTS) $<

grammar.mli grammar.ml: grammar.mly
	$(YACC) $(YACCOPTS) --external-tokens Vparser --base grammar $<

vparser.mli: grammar.mly
	$(YACC) $(YACCOPTS) --only-tokens -b vparser $<

ord.ml: ord.sh vparser.cmi
	sh ord.sh

vparser.cmi: vparser.mli
	ocamlc -g -c vparser.mli

test: vtop
	ocamldebug ./vparser

debug: vtop
	ocamldebug ./vtop

include .depend
