import sys

import num2word

word_to_num = {num2word.word(num).lower(): num for num in range(2, 11)}


def get_file_name() -> str:
    return sys.argv[1]


def read_file(file_name: str) -> list:
    with open(file_name, 'r') as input_file:
        return input_file.read().split()


def solve(file_contents) -> str:
    output_string = ""
    for index, word in enumerate(file_contents):
        if word in word_to_num:
            continue
        try:
            next_word = file_contents[index+1]
        except IndexError:
            next_word = "not numerical"
        output_string += word if next_word not in word_to_num else " ".join([word] * word_to_num[next_word])
        output_string += " "

    return output_string.strip()





file_name = get_file_name()
file_contents = read_file(file_name)
solution = solve(file_contents)

print(f"File contents: {file_contents}")
print(f"Solution: {solution}")

