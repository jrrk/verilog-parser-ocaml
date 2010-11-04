.SUFFIXES: .ml .mli .cmi .cmo

test:  vparser.cmi ord.cmo test.cmi test.cmo
	ocamlfind ocamlc -g -package "str,netstring" -linkpkg -o $@ ord.cmo test.cmo

test.mli: test.ml vparser.cmi
	ocamlfind ocamlc -i -package "str,netstring" $< > $@

.mli.cmi:
	ocamlfind ocamlc -c -package "str,netstring" $<

.ml.cmo:
	ocamlfind ocamlc -c -g -package "str,netstring" $<

ord.ml: other.cmi
	echo open String > $@
	echo let getstr tok = match tok with >> $@
	grep \| other.mli | cut -d\( -f1 | tr '\011' ' ' |\
	sed -e 's=|[\ ]*\([A-Z0-9_\ of]*\)=|\ Other.\1 -> uppercase(\"\1\")=' -e 's= of= arg=' -e 's= of ==' >> $@

ord.mli: ord.ml
	ocamlfind ocamlc -i -package "str,netstring" $< > $@

other.mli: grammar_sysver.mli
	cp $< $@

vlexer.ml vlexer.mli : vlexer.mll
	ocamllex $<

convert: test
	./test "annexA_bnf_3_1_final.html" "htmlcodes.htm" "other.mly" "junk"
	ocamlyacc -v other.mly

svparser: other.cmi ord.ml ord.cmi ord.cmo setup.cmi setup.cmo globals.cmi globals.cmo other.cmo vlexer.cmo vparse.cmi vparse.cmo
	ocamlfind ocamlmktop -g -package "unix" -linkpkg -o $@ ord.cmo setup.cmo globals.cmo other.cmo vlexer.cmo vparse.cmo

clean:
	rm -f test.mli test.cmi test.cmo test ord.ml

ord.cmo: ord.cmi
