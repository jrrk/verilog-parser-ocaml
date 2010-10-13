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

.PHONY: menhir ocamlyacc

TARGET = vparser
#YACC = menhir -v --trace # --table
YACC = ocamlyacc
#YACCOPTS = -v
#LEXOPTS = -ml

CMO1 = ord.cmo setup.cmo vlexer.cmo globals.cmo dump.cmo semantics.cmo grammar.cmo
CMO2 = vparse.cmo main.cmo
CMX = ord.cmx setup.cmx vlexer.cmx globals.cmx dump.cmx semantics.cmx grammar.cmx vparse.cmx main.cmx
CML = toplevellib.cma str.cma unix.cma
CMLX = str.cmxa unix.cmxa

all:
	@echo "Choose make ocamlyacc or make menhir"

vtop: $(TARGET)
	ocamlmktop -g -o $@ $(CML) $(CMO1) $(CMO2)

vdebug: $(TARGET)
	ocamlc -g -o $@ $(CML) $(CMO1) $(CMO2)

ocamlyacc: grammar.mly
	ocamlyacc $(YACCOPTS) $<
	mv -f grammar.mli grammar.mli.old
	sed 's=\(> \)\(token\)=\1Vparser.\2=' < grammar.mli.old > grammar.mli
	cat grammar.mli | grep -v : | grep -v \> >vparser.mli
	echo exception Error >> grammar.mli
	rm -f vparser.ml
	make vparser vdebug vtop vopt

menhir: grammar.mly
	menhir --trace --only-tokens --base vparser $<
	menhir --trace --external-tokens Vparser --base grammar $<
	make vparser vdebug vtop vopt

grammar.mli grammar.ml: grammar.mly
	@echo "Choose make ocamlyacc or make menhir"; false

$(TARGET): $(CMO1) $(CMO2) mytoploop.cmo
	ocamlc.opt -g -o $@ $(CML) $(CMO1) mytoploop.cmo $(CMO2)

depend: grammar.ml vlexer.ml
	ocamldep *.ml *.mli > .depend

clean:
	rm -rf *.cmi *.cmo *.cmx *.o vopt vtop $(TARGET)
	rm -rf grammar.ml grammar.mli vlexer.ml vlexer.mli grammar.mli grammar.ml ord.ml

.SUFFIXES: .ml .mli .mll .mly .cmo .cmi .cmx

.ml.cmo:
	ocamlc.opt -g -c $<

.mli.cmi:
	ocamlc.opt -g -c $<

.mll.ml:
	ocamllex.opt $(LEXOPTS) $<

.ml.cmx:
	ocamlopt.opt -g -c $<

ord.ml: ord.sh grammar.cmi
	sh ord.sh

vparser.cmi: grammar.mli
	ocamlc.opt -g -c vparser.mli

test: vtop
	ocamldebug ./vparser

debug: vtop
	ocamldebug ./vtop

vopt: $(CMX)
	ocamlopt.opt -g -o $@ $(CMLX) $(CMX)

INC = /home/jrrk/cmd/src/ocaml-3.12.0

I = -I $(INC)/driver -I $(INC)/toplevel -I $(INC)/bytecomp -I $(INC)/parsing -I $(INC)/utils -I $(INC)/typing

mytoploop.cmo: mytoploop.ml
	ocamlc.opt -g -c $I $<

mytoploop.cmi: mytoploop.mli
	ocamlc.opt -g -c $I $<

include .depend
