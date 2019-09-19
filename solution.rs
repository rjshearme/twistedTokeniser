extern crate regex;

use std::env;
use std::fs;
use regex::Regex;

fn get_file_contents(file_name: String) -> String {
    fs::read_to_string(file_name).expect("Something went wrong reading the file")
}

// fn process_file_contents(file_contents: String) -> Vec<String> {
//     file_contents = file_contents.to_lowercase().repl
// }

fn main() {
    let args: Vec<String> = env::args().collect();
    let file_name: String = args[1].to_string();
    println!("{:?}", file_name);

    let contents: String = get_file_contents(file_name);
    contents.to_lowercase();
    println!("{}", contents)


}
