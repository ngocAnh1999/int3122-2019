import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Word.dart';

class WordService{
  Future<List<Word>> findWords({int bookId, int unitId}) async {
    QuerySnapshot result = await Firestore.instance
      .collection('words')
      .where('book_id', isEqualTo: bookId)
      .where('unit_id', isEqualTo: unitId)
      .getDocuments();
    return result.documents.map((snapshot) => Word.fromSnapshot(snapshot)).toList();
  }

  Future<String> findSourceFromImageName(String imageName) async {
    if (imageName == null) 
      return 'https://www.clipartwiki.com/clipimg/detail/83-830547_child-playing-png-kids-png.png';

    QuerySnapshot result = await Firestore.instance
      .collection('books')
      .where('img_name', isEqualTo: imageName)
      .getDocuments();
    
    if (result.documents.length == 0){
      print('Length = 0');
      return 'https://www.clipartwiki.com/clipimg/detail/83-830547_child-playing-png-kids-png.png';
    
    }
    return result.documents[0]['cover_url'];
  }
}