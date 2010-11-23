.SUFFIXES: .ml .mli .cmi .cmo

.mli.cmi:
	ocamlfind ocamlc -c -package "str" $<

.ml.cmo:
	ocamlfind ocamlc -c -g -package "str" $<

liberty.ml: liberty_parser.cmi
	echo open Liberty_parser > $@
	echo open String >> $@
	echo let getstr tok = match tok with >> $@
	grep \| liberty_parser.mli | cut -d\( -f1 | tr '\011' ' ' |\
	sed -e 's=|[\ ]*\([A-Za-z0-9_\ of]*\)=|\ \1 -> uppercase(\"\1\")=' -e 's= of= arg=' -e 's= of ==' >> $@

liberty_parser.ml liberty_parser.mli: liberty_parser.mly
	ocamlyacc -v liberty_parser.mly

liberty_parser.cmo: liberty_parser.ml
	ocamlc -c $<

vlexer.ml vlexer.mli : vlexer.mll
	ocamllex $<

lparser: liberty_parser.cmi liberty.cmo setup.cmi setup.cmo globals.cmi globals.cmo liberty_parser.cmo vlexer.cmo vparse.cmi vparse.cmo main.cmo
	ocamlfind ocamlc -g -package "unix" -linkpkg -o $@ liberty.cmo setup.cmo globals.cmo liberty_parser.cmo vlexer.cmo vparse.cmo main.cmo

clean:
	rm -f tokens.log liberty_parser.automaton test.mli test.cmi test.cmo test ord.ml liberty_parser.ml *.cmi *.cmo

ord.cmo: ord.cmi
