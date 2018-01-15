#!/bin/bash

cd $(dirname $0)

TEXTLINT=./node_modules/.bin/textlint
CONFIG_FILE=.textlintrc.enable-spellchecker
DOWNLOAD_FILE=$1
CONTENTS_ROOT='//div[contains(@class, "editable_contents")]'
OUTPUT_FILE=$(mktemp).md

curl -s $DOWNLOAD_FILE | xmllint --html --xpath "$CONTENTS_ROOT" - 2> /dev/null | pandoc -f html -t gfm > $OUTPUT_FILE

$TEXTLINT -c $CONFIG_FILE $OUTPUT_FILE

rm $OUTPUT_FILE
