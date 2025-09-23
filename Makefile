.PHONY: run
run:
	dune exec ./bin/main.exe

.PHONY: test
test:
	dune runtest

.PHONY: build
build:
	dune build

.PHONY: fmt
fmt:
	dune build @fmt

