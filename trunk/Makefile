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
YACC = ocamlyacc -v
#LEXOPTS = -ml

CMO = ord.cmo setup.cmo vlexer.cmo globals.cmo grammar.cmo dump.cmo mytoploop.cmo semantics.cmo vparse.cmo main.cmo
CML = toplevellib.cma str.cma # extLib.cma

vtop: $(TARGET)
	ocamlmktop -g -o vtop $(CML) $(CMO)

ocamlyacc: grammar.mly
	ocamlyacc -v $<
	mv -f grammar.mli grammar.mli.old
	sed 's=\(> \)\(token\)=\1Vparser.\2=' < grammar.mli.old > grammar.mli
	cat grammar.mli | grep -v : | grep -v \> >vparser.mli
	echo exception Error >> grammar.mli
	make vtop

menhir: grammar.mly
	menhir --trace --only-tokens --base vparser $<
	menhir --trace --external-tokens Vparser --base grammar $<
	make vtop

grammar.mli grammar.ml:
	echo "Choose make ocamlyacc or make menhir"

$(TARGET): $(CMO)
	ocamlc.opt -g -o $@ $(CML) $(CMO)

depend: grammar.ml vlexer.ml
	ocamldep *.ml *.mli > .depend

clean:
	rm -rf *.cmi *.cmo vtop $(TARGET)
	rm -rf grammar.ml grammar.mli vlexer.ml vlexer.mli grammar.mli grammar.ml ord.ml

.SUFFIXES: .ml .mli .mll .mly .cmo .cmi

.ml.cmo:
	ocamlc.opt -g -c $<

.mli.cmi:
	ocamlc.opt -g -c $<

.mll.ml:
	ocamllex.opt $(LEXOPTS) $<

ord.ml: ord.sh grammar.cmi
	sh ord.sh

vparser.cmi: grammar.mli
	ocamlc.opt -g -c vparser.mli

test: vtop
	ocamldebug ./vparser

debug: vtop
	ocamldebug ./vtop

I = -I /home/jrrk/cmd/src/ocaml-3.12.0/driver -I /home/jrrk/cmd/src/ocaml-3.12.0/toplevel -I /home/jrrk/cmd/src/ocaml-3.12.0/bytecomp -I /home/jrrk/cmd/src/ocaml-3.12.0/parsing -I /home/jrrk/cmd/src/ocaml-3.12.0/utils -I /home/jrrk/cmd/src/ocaml-3.12.0/typing

mytoploop.cmo: mytoploop.ml
	ocamlc.opt -g -c $I $<

mytoploop.cmi: mytoploop.mli
	ocamlc.opt -g -c $I $<

include .depend
