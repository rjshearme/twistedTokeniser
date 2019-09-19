use std::env;
use std::fs;
use std::collections::HashMap;

use regex::Regex;

fn get_file_contents(file_name: &str) -> String {
    fs::read_to_string(file_name).expect("Something went wrong reading the file")
}

fn process_file_contents(file_contents: &str) -> String{
    let re = Regex::new(r"[^a-z0-9 ]").unwrap();
    re.replace_all(&file_contents.to_lowercase().replace("\n", " "), "").to_string()
}

fn get_word_counts(processed_contents: &str) {
    let mut word_counts: HashMap<String, String> = HashMap::new();
    word_counts.insert("test".to_string(), "foo".to_string());
    println!("{}", word_counts.remove(&"foo".to_string()));
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let file_name: String = args[1].to_string();
    println!("{:?}", file_name);

    let contents = get_file_contents(&file_name);
    let processed_contents = process_file_contents(&contents);
    println!("{}", processed_contents);
    // let processed_contents = process_file_contents(contents);
}
