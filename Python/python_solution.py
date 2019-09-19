from collections import defaultdict
import logging
import re
import sys

import num2word

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger("Test logger")

word2num = {
    num2word.word(num).lower(): num
    for num in range(2, 11)
}


def get_sys_argument(argument: int) -> str:
    try:
        return sys.argv[argument]
    except IndexError:
        logging.info("No file was provided")
        return ""


def read_file(file_name: str) -> str:
    try:
        with open(file_name, 'r') as input_file:
            return input_file.read()
    except FileNotFoundError:
        return []


def process_file(file_contents: str) -> list:
    file_contents = file_contents.replace("\n", " ")
    return re.sub(r"[^a-z0-9 ]", "", file_contents.lower()).split()


def twist(file_contents: list) -> dict:
    output_dict = defaultdict(int)
    for index, word in enumerate(file_contents):
        if word in word2num:
            continue
        try:
            next_word = file_contents[(index+1)]
        except IndexError:
            next_word = "no multiplication"
        output_dict[word] += word2num.get(next_word, 1)
    return output_dict


def sort_output(output: dict) -> list:
    return sorted(output.items(), key=lambda item: (item[1], item[0]), reverse=True)


def print_output(output: list, limit: int) -> None:
    for item in output[:limit]:
        print(f"{item[1]} {item[0]}")



if __name__=="__main__":
    file_name = get_sys_argument(1)
    raw_file_contents = read_file(file_name)
    processed_file_contents = process_file(raw_file_contents)
    solution = twist(processed_file_contents)
    sorted_solution = sort_output(solution)
    print_output(sorted_solution, 5)
