#!/bin/bash

#######################################
#
# Bash script file for travis-ci.org.
#
#######################################

OPAM_DEPENDS="ocamlfind yojson"

case "$OCAML_VERSION,$OPAM_VERSION" in
3.12.1,1.0.0) ppa=avsm/ocaml312+opam10 ;;
3.12.1,1.1.0) ppa=avsm/ocaml312+opam11 ;;
4.00.1,1.0.0) ppa=avsm/ocaml40+opam10 ;;
4.00.1,1.1.0) ppa=avsm/ocaml40+opam11 ;;
4.01.0,1.0.0) ppa=avsm/ocaml41+opam10 ;;
4.01.0,1.2.0) ppa=avsm/ocaml41+opam12 ;;
4.02.1,1.0.0) ppa=avsm/ocaml42+opam10 ;;
4.02.1,1.2.0) ppa=avsm/ocaml42+opam12 ;;
*) echo Unknown $OCAML_VERSION,$OPAM_VERSION; exit 1 ;;
esac

# install ocaml ubuntu package
echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra opam
export OPAMYES=1
opam init
opam install ${OPAM_DEPENDS}
eval `opam config env`

# install Ruby to test JSON
sudo apt-get install -qq ruby rubygems
sudo gem install json

# build csfp
cd ocaml
make

# run test
make test
