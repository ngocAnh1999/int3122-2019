import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Book.dart';

class BookService {
  Future<List<Book>> findBooks() async {
    QuerySnapshot result = await Firestore.instance
      .collection('books')
      .orderBy('book_id')
      .getDocuments();
    return result.documents.map((snapshot) => Book.fromSnapshot(snapshot)).toList();
  }
}