.SUFFIXES: .ml .mli .cmi .cmo

.mli.cmi:
	ocamlfind ocamlc -c -package "str" $<

.ml.cmo:
	ocamlfind ocamlc -c -g -package "str" $<

lparser: liberty_parser.cmi liberty.cmo setup.cmi setup.cmo globals.cmi globals.cmo liberty_parser.cmo vlexer.cmo vparse.cmi mytoploop.cmo vparse.cmo main.cmo
	ocamlfind ocamlmktop -g -package "str,unix" -linkpkg -o $@ toplevellib.cma liberty.cmo setup.cmo globals.cmo liberty_parser.cmo vlexer.cmo mytoploop.cmo vparse.cmo main.cmo

liberty.ml: liberty_parser.cmi
	echo open Liberty_parser > $@
	echo open String >> $@
	echo let getstr tok = match tok with >> $@
	grep \| liberty_parser.mli | cut -d\( -f1 | tr '\011' ' ' |\
	sed -e 's=|[\ ]*\([A-Za-z0-9_\ of]*\)=|\ \1 -> (\"\1\")=' -e 's= of= arg=' -e 's= of ==' >> $@

liberty_parser.ml liberty_parser.mli: liberty_parser.mly
	ocamlyacc -v liberty_parser.mly
#	menhir -v --trace liberty_parser.mly

liberty_parser.cmo: liberty_parser.ml
	ocamlc -c $<

vlexer.ml vlexer.mli : vlexer.mll
	ocamllex $<

clean:
	rm -f lparser liberty.ml vlexer.ml tokens.log liberty_parser.automaton liberty_parser.output test.mli test.cmi test.cmo test ord.ml liberty_parser.ml *.cmi *.cmo report.*report

ord.cmo: ord.cmi

INC = /home/utils/ocaml-3.12.0
I = -I $(INC)/driver -I $(INC)/toplevel -I $(INC)/bytecomp -I $(INC)/parsing -I $(INC)/utils -I $(INC)/typing

mytoploop.cmo: mytoploop.ml
	ocamlc.opt -g -c $I $<
