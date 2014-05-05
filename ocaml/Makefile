.PHONY: build clean clean-all dist

LIB=str.cma

dist: build clean

build: sfp

sfp: sfp.ml domain.cmo sfplexer.cmo sfpparser.cmo
	ocamlc -c sfp.ml
	ocamlc -o sfp $(LIB) domain.cmo sfplexer.cmo sfpparser.cmo sfp.cmo

sfpparser.cmo: domain.cmo
	ocamlyacc sfpparser.mly
	ocamlc -c sfpparser.mli
	ocamlc -c sfpparser.ml

sfplexer.cmo: sfplexer.mll sfpparser.cmo
	ocamllex sfplexer.mll
	ocamlc -c sfplexer.ml

domain.cmo: domain.ml
	ocamlc -c domain.ml

clean:
	@rm -f *.{cmo,mli,cmi} sfpparser.ml sfplexer.ml

clean-all: clean
	@rm -f sfp

clean-build: clean-all build

test: clean-all build
	@./test.sh
