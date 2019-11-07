
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';

class BookServices {
  final Firestore firestore = Firestore.instance;
  Future<List<Book>> getBooks() async {
    QuerySnapshot result = await firestore.collection('books').orderBy('book_id').getDocuments();
    return result.documents.map((snapshot) => Book.fromSnapshot(snapshot)).toList();
  }
  
  Future<List<Book>> getEBooks() async {
    QuerySnapshot result = await firestore.collection('EnglishBook').orderBy('book_id').getDocuments();
    return result.documents.map((snapshot) => Book.fromESnapshot(snapshot)).toList();
  }
}