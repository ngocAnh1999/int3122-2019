import '../models/Word.dart';

class WordHelper {
  String getImageSource(Word word){
    if (word.imageName == null) 
      return 'https://static.spineuniverse.com/sites/default/files/lead-images/article/4811-kid21211609_m.jpg';
    return 'https://s.sachmem.vn/public/dics_stable/${word.imageName}/${word.content}.jpg';
  }
}