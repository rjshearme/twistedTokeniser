file_name = ARGV[0]

word2num = Hash.new(1)
word2num['two'] = 2
word2num['three'] = 3
word2num['four'] = 4
word2num['five'] = 5
word2num['six'] = 6
word2num['seven'] = 7
word2num['eight'] = 8
word2num['nine'] = 9
word2num['ten'] = 10

file_contents = ''
File.open(file_name, 'r') do |f|
  f.each_line do |line|
    file_contents << ' ' << line
  end
end

processed_contents = file_contents.downcase.gsub(/[^a-z0-9 ]/, '').split

word_counts = Hash.new(0)
processed_contents.each_with_index do |word, index|
  next_index = (index + 1) < processed_contents.length ? index + 1 : index
  next_word = processed_contents[next_index]
  unless word2num.key?(word)
    multiplier = word2num[next_word]
    word_counts[word] += multiplier
  end
end

sorted_counts = (word_counts.sort_by { |k, v| [v, k] }).reverse[0..4]
sorted_counts.each do |word, count|
  puts "#{count} #{word}"
end
