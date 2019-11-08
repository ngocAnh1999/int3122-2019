import '../models/Word.dart';
import 'dart:math';

class RandomHelper {
  Random _random = new Random();

  List<Word> generateQuestions({int answerIndex, int numberOfQuestion ,List<Word> source}){    
    List<int> fetchedIndeces = _generateItems(
      numberOfQuestion: numberOfQuestion-1,
      source: source,
      fetchedIndeces: [answerIndex]
    );

    return fetchedIndeces.map((index) => source[index]).toList();
  }


  List<int> _generateItems({ int numberOfQuestion, List<dynamic> source, List<int> fetchedIndeces }){
    if (numberOfQuestion == 0)
      return fetchedIndeces;
    int randomIndex;
    do {
      randomIndex = _random.nextInt(source.length - 1);
    } while (fetchedIndeces.indexOf(randomIndex) != -1); 

    fetchedIndeces.add(randomIndex);
    return _generateItems(
      numberOfQuestion: numberOfQuestion - 1,
      source: source,
      fetchedIndeces: fetchedIndeces
    );   
  } 
}