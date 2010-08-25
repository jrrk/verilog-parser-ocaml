echo let ord tok = match tok with > ord.ml
grep \| vparser.mli | cat -n | cut -d\( -f1 | tr '\011' ' ' |\
sed -e 's=\([0-9\t\ ]*\)|\([A-Z0-9_\ of]*\)=|\ Vparser.\2 -> \1=' -e 's= of= arg=' >> ord.ml
echo let getstr tok = match tok with >> ord.ml
grep \| vparser.mli | cut -d\( -f1 | tr '\011' ' ' |\
sed -e 's=|\([A-Z0-9_\ of]*\)=|\ Vparser.\1 -> \"\1\"=' -e 's= of= arg=' >> ord.ml
