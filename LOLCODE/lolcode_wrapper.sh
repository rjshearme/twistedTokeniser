#!/usr/bin/env bash

input_file_contents=$(echo $(<$1))

printf "\
HAI 1.2
I HAS A INPUWT ITZ \"$input_file_contents\"
VISIBLE INPUWT
KTHXBYE" \
> lcode.lols

printf "Hello, AGAIN" | lci lcode.lols