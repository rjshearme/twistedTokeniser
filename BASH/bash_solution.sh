#!/usr/local/bin/bash

declare -A word2num

word2num["two"]=2
word2num["three"]=3
word2num["four"]=4
word2num["five"]=5
word2num["six"]=6
word2num["seven"]=7
word2num["eight"]=8
word2num["nine"]=9
word2num["ten"]=10

read -ra input_file_contents <<< $(echo $(<$1)| sed 's/[:;,.]//g' | tr '[:upper:]' '[:lower:]')

for ((i=0; i<${#input_file_contents[@]}; i++)); do
    word=(${input_file_contents[i]})
    word_in_word2num=word2num[$word]
    next_index=$(( (i+1) < (${#input_file_contents[@]}) ? i+1 : i ))
    next_word=(${input_file_contents[next_index]})

    if ! (( word_in_word2num )) && ! (( word2num[$next_word] )); then
        twisted_string="$twisted_string$word\n"
    elif ! (( word_in_word2num )); then
        for ((k=0; k<(word2num[$next_word]); k++)); do
            twisted_string="$twisted_string$word\n"
        done
    fi
done

printf "$twisted_string" | sort | uniq -c | sort -nr | head -n 5
