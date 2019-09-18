import java.io.*;
import java.util.*;

public class Solution {
    public static void main(String[] args){
        ArgsRetriever argRet = new ArgsRetriever(args);
        String inputFile, fileContents;
        HashMap<String, Integer> wordCounts;
        FileTwister fTwister;
        int limit = 5;

        try {
            inputFile = argRet.getArg(0);
        } catch (IllegalArgumentException ex) {
            inputFile = "";
            System.out.println(ex.toString());
        }

        try {
            fileContents = FileReader.readFile(inputFile);
        } catch (FileNotFoundException ex) {
            fileContents = "";
            System.out.println(ex.toString());
        }
        Map<String, Integer> word2num = new HashMap<>();
        word2num.put("two", 2);
        word2num.put("three", 3);
        word2num.put("four", 4);
        word2num.put("five", 5);
        word2num.put("six", 6);
        word2num.put("seven", 7);
        word2num.put("eight", 8);
        word2num.put("nine", 9);
        word2num.put("ten", 10);


        fTwister = new FileTwister(word2num);
        List<Map.Entry<String, Integer>> list = fTwister.twist(fileContents, limit);

        for (Map.Entry<String, Integer> entry : list) {
            System.out.println(entry.getKey() + " " + entry.getValue());
        }

    }
}

class ArgsRetriever {
    private String[] args;

    public ArgsRetriever(String[] args_) {
        args = args_;
    }

    String getArg(int n) {
        if (args.length <= n) {
            throw new IllegalArgumentException("One and only one file name must be provided.");
        } else {
            return args[n];
        }
    }
}

class FileReader {

    static String readFile(String fileName) throws FileNotFoundException{
        File file = new File(fileName);
        Scanner input = new Scanner(file);
        StringBuilder fileContents = new StringBuilder();

        while (input.hasNextLine()) {
            fileContents.append(" ").append(input.nextLine());
        }
        return fileContents.toString();
    }
}

class FileTwister {
    Map<String, Integer> word2num;

    public FileTwister(Map<String, Integer> word2num_) {
        word2num = word2num_;
    }


    List<Map.Entry<String, Integer>> twist(String fileContents, int limit) {
        HashMap<String, Integer> wordCounts = new HashMap<String, Integer>();

        String[] fileWords = fileContents.toLowerCase()
                .replaceAll("[^A-z0-9\\s]", "")
                .split("\\s+");

        fileWords = Arrays.stream(fileWords).filter(x -> !x.isEmpty()).toArray(String[]::new);

        for (int i=0; i<fileWords.length; i++) {
            String word, next_word;
            boolean wordIsNumber;
            int count, multiplier;

            word = fileWords[i];
            next_word = fileWords[(i+1 < fileWords.length ? i+1 : i)];
            wordIsNumber = word2num.containsKey(word);
            if (!wordIsNumber) {
                wordCounts.putIfAbsent(word, 0);
                count = wordCounts.get(word);
                multiplier = word2num.containsKey(next_word) ? word2num.get(next_word) : 1;
                wordCounts.put(word, count + multiplier);
            }
        }

        List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(wordCounts.entrySet());
        list.sort(new ValueThenKeyComparator<String, Integer>());

        return list.subList(0, limit);
    }
}

class ValueThenKeyComparator<K extends Comparable<? super K>, V extends Comparable<? super V>> implements Comparator<Map.Entry<K, V>> {
    public int compare(Map.Entry<K, V> a, Map.Entry<K, V> b) {
        int cmp1 = b.getValue().compareTo((a.getValue()));
        if (cmp1 != 0) {
            return cmp1;
        } else {
            return a.getKey().compareTo(b.getKey());
        }
    }

}