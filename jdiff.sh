#!/usr/bin/env bash

file2="${@:(-1):1}"
file1="${@:(-2):1}"

# some objects we'll want to ignore
ignorefile_opt="${@:(-3):1}"
ignorefile=''
if [ ! -f $ignorefile_opt ]; then

  if [[ $ignorefile_opt =~ "ignorefile" ]]; then
    # it's an ignorefile option
    pattern="*="
    ignorefile="${ignorefile_opt#*$pattern}"
    diff_opt_num="$(($#-3))"
  else
    # it's a diff option
    diff_opt_num="$(($#-2))"
  fi
fi

if [ $ignorefile ]; then
  ignore_lines=$(sed -e '$!s/$/?, /' -e '$s/$/?/' -e 's/^/./' $ignorefile | tr -d '\n') || ''
fi

if [[ -n $ignore_lines ]]; then
  jqscript="walk(if type == \"array\" then sort else . end) | del(.. | ${ignore_lines})"
else
  jqscript="walk(if type == \"array\" then sort else . end)"
fi


diff ${@:1:$diff_opt_num} <(jq --sort-keys "${jqscript}" < "$file1") <(jq --sort-keys "${jqscript}" < "$file2")
