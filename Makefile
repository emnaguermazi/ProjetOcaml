
main:
	ocamlbuild ftest.native
	ocamlbuild ctest.native

format:
	ocp-indent --inplace src/*

clean:
	rm -rf _build/
	rm ftest.native
	rm ctest.native
