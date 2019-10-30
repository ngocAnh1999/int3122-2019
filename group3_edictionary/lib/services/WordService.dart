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
}