package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"strings"
  "sort"
  // "strconv"
)

type sortableWordCount struct {
	word string
	count int
}

func newSortableWordCount(_word string, _count int) (*sortableWordCount) {
	wc := sortableWordCount{word: _word, count: _count}
	return &wc
}

func readText(input_file string) (string, error) {
	file, err := os.Open(input_file)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var input_text string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		input_text += " " + scanner.Text()
	}
	return input_text, scanner.Err()
}

func preProcess(input_text string) string {
	re := regexp.MustCompile(`[.,;:]`)
	input_text = re.ReplaceAllString(input_text, "")
	input_text = strings.ToLower(input_text)
	return input_text
}

func getWordCounts(input_text string, word2Num map[string]int) map[string]int {
	wordCount := map[string]int{}
    wordArray := strings.Fields(input_text)
	for i, word := range wordArray {
    nextWord := wordArray[i]
    if (i+1) < len(wordArray){
      nextWord = wordArray[i+1]
    }
		multiplier, _ := word2Num[nextWord]
    _, wordIsNumber := word2Num[word]
    if multiplier == 0 {
      multiplier = 1
    }
    if !wordIsNumber {
      wordCount[word] += multiplier
    }
	}
	return wordCount
}

func sortWordCount(counts map[string]int) ([]sortableWordCount) {
    sortingArray := make([]sortableWordCount, 0)
    for key, value := range counts {
				sortingArray = append(sortingArray, *newSortableWordCount(key, value))
    }

    sort.Slice(sortingArray[:], func(i, j int) bool {
			if sortingArray[i].count == sortingArray[j].count {
				return sortingArray[i].word > sortingArray[j].word
			} else {
				return sortingArray[i].count > sortingArray[j].count
			}
		})
    limit := len(sortingArray)
    if limit > 5 {
      limit = 5
    }
    return sortingArray[:limit]
}

func main() {
  word2Num := make(map[string]int)
  word2Num["two"] = 2
  word2Num["three"] = 3
  word2Num["four"] = 4
  word2Num["five"] = 5
  word2Num["six"] = 6
  word2Num["seven"] = 7
  word2Num["eight"] = 8
  word2Num["nine"] = 9
  word2Num["ten"] = 10

	inputFile := os.Args[1]
	fileContents, fileReadErr := readText(inputFile)
	if fileReadErr != nil {
		log.Fatalf("readLines: %s", fileReadErr)
	}

	processedFileContents := preProcess(fileContents)
	wordCount := getWordCounts(processedFileContents, word2Num)
  sortedWordCount := sortWordCount(wordCount)
  for _, sWC := range sortedWordCount {
    fmt.Printf("%d %s\n", sWC.count, sWC.word)
	}
}
