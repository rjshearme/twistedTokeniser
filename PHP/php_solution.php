<?php
$word2num["two"]=2;
$word2num["three"]=3;
$word2num["four"]=4;
$word2num["five"]=5;
$word2num["six"]=6;
$word2num["seven"]=7;
$word2num["eight"]=8;
$word2num["nine"]=9;
$word2num["ten"]=10;

function process_file_contents($file_contents) {
  $file_contents = strtolower($file_contents);
  $file_contents = preg_replace("/[.,:;]/", "", $file_contents);
  $file_contents = preg_split("/\s+/", $file_contents);
  return $file_contents;
}

function get_word_count($words_array, $word2num) {
  for($i=0; $i<count($words_array); $i++) {
    $word = $words_array[$i];
    $next_word = $words_array[($i+1 < count($words_array)) ? $i+1 : $i];
    $word_is_number = array_key_exists($word, $word2num);
    if (!$word_is_number && $word){
      $multiplier = array_key_exists($next_word, $word2num) ? $word2num[$next_word] : 1;
      $word_count_map[$word] += $multiplier;
    }
  }
  return $word_count_map;
}

function sort_value_then_key($map) {
  $sorting_array = array();
  foreach($map as $key => $value) {
    array_push($sorting_array, array($value, $key));
  }
  arsort($sorting_array);
  return $sorting_array;
}

function get_top_n($array, $n) {
  return array_slice($array, 0, $n);
}

$input_file = $argv[1];
$input_file_contents = file_get_contents($input_file);
$processed_file_contents = process_file_contents($input_file_contents);
$word_count_map = get_word_count($processed_file_contents, $word2num);
$sorted_map = sort_value_then_key($word_count_map);
$top_5_sorted_map = get_top_n($sorted_map, 5);

foreach ($top_5_sorted_map as $value) {
  echo $value[0] . " " . $value[1] . "\n";
}
?>
