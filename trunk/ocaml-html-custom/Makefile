.SUFFIXES: .ml .mli .cmi .cmo

MENHIR = /home/jrrk/godi/lib/ocaml/site-lib/menhirLib

test:	grammar_sysver.cmi grammar_sysver.cmo test.cmi test.cmo
	ocamlfind ocamlc -g -package "str,netstring" -linkpkg -o $@ grammar_sysver.cmo test.cmo

test.mli: test.ml grammar_sysver.cmi
	ocamlfind ocamlc -i -package "str,netstring" $< > $@

.mli.cmi:
	ocamlfind ocamlc -c -package "str,netstring" $<

.ml.cmo:
	ocamlfind ocamlc -c -g -package "str,netstring" $<

grammar_sysver.ml: grammar_sysver.cmi
	grep -v val $*.mli > $@
	echo open String >> $@
	echo let getstr tok = match tok with >> $@
	grep \| grammar_sysver.mli | cut -d\( -f1 | tr '\011' ' ' |\
	sed -e 's=|[\ ]*\([A-Za-z0-9_\ of]*\)=|\ \1 -> uppercase(\"\1\")=' -e 's= of= arg=' -e 's= of ==' >> $@

other.ml: other.mly
	menhir -v --trace --table --infer other.mly --external-tokens Grammar_sysver 2> other.warnings

other.cmo: other.ml
	ocamlc -c -I $(MENHIR) $<

vlexer.ml vlexer.mli : vlexer.mll
	ocamllex $<

convert: test
	./test "annexA_bnf_3_1_final.html" "htmlcodes.htm" "other.mly" "junk"

svparser: grammar_sysver.cmi other.cmi grammar_sysver.cmo setup.cmi setup.cmo globals.cmi globals.cmo other.cmo vlexer.cmo vparse.cmi vparse.cmo main.cmo
	ocamlfind ocamlc -g -package "unix" -linkpkg -o $@ $(MENHIR)/menhirLib.cmo grammar_sysver.cmo setup.cmo globals.cmo other.cmo vlexer.cmo vparse.cmo main.cmo

clean:
	rm -f tokens.log other.automaton other.mly test.mli test.cmi test.cmo test ord.ml other.ml *.cmi *.cmo

ord.cmo: ord.cmi
