#!/bin/bash

#######################################
#
# Bash script file for travis-ci.org.
# This only supports OCaml compiler.
#
#######################################

#######################################
# csf : ocaml compiler
#######################################

# install ocaml
echo "yes" | sudo add-apt-repository ppa:avsm/ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-findlib opam

# install required library
opam install -y yojson

# compile csf
cd ocaml
make travis
cd ../test

# run test script for csf
bash -ex travis-ocaml.sh

#######################################
# sfParser: scala compiler
#######################################

#cd test
#bash -ex travis-scala.sh
#cd ..
