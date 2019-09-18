var fs = require('fs');

const word2num = {
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
    'ten': 10,
}

var input_filename = process.argv[2];
var input_text = fs.readFileSync(input_filename).toString().toLowerCase().replace(/[.,;:]/g, "").split(" ");

var word_counts = {};
for (let i=0; i<input_text.length; i++) {
    let word = input_text[i];
    let next_word = input_text[i+1]
    if (!(word in word2num)) {
        let multiplier = word2num[next_word] || 1;
        word_counts[word] = (word_counts[word] || 0) + multiplier;
    }

}

var counted_words = Object.keys(word_counts).map((key) => [word_counts[key], key]);
counted_words.sort((fst, snd) => ((snd[0] == fst[0]) ? 0 : (snd[0] > fst[0] ? 1 : -1)) || (snd[1] > fst[1] ? 1 : -1));

for (let word of counted_words.slice(0,5)) {
    console.log(word[0] + " " + word[1]);
}