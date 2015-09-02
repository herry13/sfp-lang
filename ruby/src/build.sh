#!/bin/sh

BASEDIR="$(dirname "$0")"
CURRENTDIR=`pwd`

cd $BASEDIR

antlr4ruby SfpLang.g

rm -f SfpLang.tokens
mv -f SfpLangLexer.rb ../lib/sfp
mv -f SfpLangParser.rb ../lib/sfp

cd $CURRENTDIR
