#!/usr/bin/env bash

file2="${@:(-1):1}"
file1="${@:(-2):1}"

# some objects we'll want to ignore
ignorefile_opt="${@:(-3):1}"
if [ ! -z $ignorefile_opt ]; then
  pattern="*="
  ignorefile="${ignorefile_opt#*$pattern}"
fi
ignore_lines=$(sed -e '$!s/$/?, /' -e '$s/$/?/' -e 's/^/./' $ignorefile | tr -d '\n')


diff_options=$(($#-3))

jqscript="walk(if type == \"array\" then sort else . end) | del(.. | ${ignore_lines})"

diff ${@:1:$diff_options} <(jq --sort-keys "${jqscript}" < "$file1") <(jq --sort-keys "${jqscript}" < "$file2")
