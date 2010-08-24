//*****************************************************************************
//
//    DESCRIPTION: Verilog parser Makefile
//
//*****************************************************************************
//
// Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// General Public License or the Perl Artistic License.
//
// This code is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//*****************************************************************************
// Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
//*****************************************************************************

TARGET = vparser
YACC = menhir
#LEXOPTS = -ml
#YACCOPTS = --trace

CMO = lexer.cmo globals.cmo grammar.cmo dump.cmo main.cmo

$(TARGET): $(CMO)
	ocamlc.opt -g -o $@ $(CMO)

depend: grammar.ml lexer.ml
	ocamldep *.ml *.mli > .depend

clean:
	rm -rf *.cmi *.cmo $(TARGET)
	rm -rf grammar.ml grammar.mli lexer.ml lexer.mli vparser.mli vparser.ml

.SUFFIXES: .ml .mli .mll .mly .cmo .cmi

.ml.cmo:
	ocamlc.opt -g -c $<

.mli.cmi:
	ocamlc.opt -g -c $<

.mll.ml:
	ocamllex.opt $(LEXOPTS) $<

grammar.mli grammar.ml: grammar.mly
	$(YACC) $(YACCOPTS) --external-tokens Vparser --base grammar $<

vparser.mli: grammar.mly
	$(YACC) $(YACCOPTS) --only-tokens -b vparser $<

vparser.cmi: vparser.mli
	ocamlc.opt -g -c vparser.mli

test: vparser
	./vparser < ex/test.v

include .depend
