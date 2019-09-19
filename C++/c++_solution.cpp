#include<iostream>
#include<fstream>
#include<sstream>
#include<string>
#include<regex>
#include <boost/algorithm/string.hpp>
using namespace std;

map<string, int> getWord2NumMap() {
  map<string, int> word2num = {
    {"two", 2},
    {"three", 3},
    {"four", 4},
    {"five", 5},
    {"six", 6},
    {"seven", 7},
    {"eight", 8},
    {"nine", 9},
    {"ten", 10},
  };

  return word2num;
}

string getFileFromArgv(char** cmdArgs, int argNum) {
  string input_file = cmdArgs[argNum];

  ifstream f(input_file);
  string str;
  if(f) {
    ostringstream ss;
    ss << f.rdbuf();
    str = ss.str();
  }
  return str;
}

bool isEmpty(string s) {
  return s == "" || s == " " || s == "\n";
}

vector<string> processContents(string file_contents) {
  vector<string> result;

  std::for_each(file_contents.begin(), file_contents.end(), [](char & c){
	   c = ::tolower(c);
  });

  regex remove_punctutation("[^A-Za-z0-9 ]");
  regex remove_extra_space("\\s+");
  regex trailing_space("\\s$");
  file_contents = regex_replace(file_contents, remove_punctutation, " ");
  file_contents = regex_replace(file_contents, remove_extra_space, " ");
  file_contents = regex_replace(file_contents, trailing_space, "");

  boost::split(result, file_contents, boost::is_any_of(" "));
  vector <string>::iterator pend;
  pend = remove_if (result.begin(), result.end(), isEmpty);

  return result;
}

map<string, int> getWordCount(vector<string> file_words){
  map<string, int> word_counts;
  map<string, int> word2num = getWord2NumMap();
  for(int i=0; i<file_words.size(); i++) {
    string word, next_word;
    int next_i;

    next_i = i+1 < file_words.size() ? i+1 : i;
    word = file_words[i];
    next_word = file_words[next_i];

    if (word2num.count(word) == 0) {
      int multiplier = word2num.count(next_word) != 0 ? word2num[next_word]: 1;
      word_counts[word] += multiplier;
    }
  }

  return word_counts;
}

vector<pair<string, int>> sortWordCount(const map<string, int> &word_count){
  vector<pair<string, int>> sorted_word_count(word_count.begin(), word_count.end());

  sort(sorted_word_count.begin(), sorted_word_count.end(), [=](std::pair<string, int>& a, std::pair<string, int>& b){
    return (a.second == b.second ? (a.first > b.first) : (a.second > b.second));
  });
  return sorted_word_count;
}

int main(int argc, char** argv) {
  string raw_file;
  vector<string> file_words;
  map<string, int> word_count;
  vector<pair<string, int>> sorted_word_count;
  vector<pair<string, int>> top_five;

  raw_file = getFileFromArgv(argv, 1);
  file_words = processContents(raw_file);
  word_count = getWordCount(file_words);
  sorted_word_count = sortWordCount(word_count);
  top_five = vector<pair<string, int>>(sorted_word_count.begin(), sorted_word_count.begin()+5);

  for(auto elem : top_five){
   std::cout << elem.second<< " " << elem.first << "\n";
  }
}
