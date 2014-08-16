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
