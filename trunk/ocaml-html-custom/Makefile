.SUFFIXES: .ml .mli .cmi .cmo

test:  vparser.cmi ord.cmo test.cmi test.cmo
	ocamlfind ocamlc -g -package "str,netstring" -linkpkg -o $@ ord.cmo test.cmo

test.mli: test.ml vparser.cmi
	ocamlfind ocamlc -i -package "str,netstring" $< > $@

.mli.cmi:
	ocamlfind ocamlc -c -package "str,netstring" $<

.ml.cmo:
	ocamlfind ocamlc -c -g -package "str,netstring" $<

ord.ml: vparser.mli
	echo open String > $@
	echo let getstr tok = match tok with >> $@
	grep \| vparser.mli | cut -d\( -f1 | tr '\011' ' ' |\
	sed -e 's=|[\ ]*\([A-Z0-9_\ of]*\)=|\ Vparser.\1 -> uppercase(\"\1\")=' -e 's= of= arg=' -e 's= of ==' >> $@

convert: test
	./test "annexA_bnf_3_1_final.html" "htmlcodes.htm" "other.mly" "junk"

clean:
	rm -f test.mli test.cmi test.cmo test ord.ml
