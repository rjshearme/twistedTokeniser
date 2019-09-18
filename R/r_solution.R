num2word <- c("two"=2, "three"=3)

for (key in num2word){
    cat(key)
    cat (num2word[key])
    cat("\n")
}

fileName <- commandArgs(trailingOnly=TRUE)

file <- readChar(fileName, file.info(fileName)$size)
file <- tolower(file)
file <- gsub("[.,:;]", "", file)
fileWords <- strsplit(file, " ")

for (word in seq_along(fileWords[[1]])){
    cat(word, sep="\n")
}
