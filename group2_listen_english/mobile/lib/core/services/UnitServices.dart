import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Unit.dart';

class UnitServices {

  final Firestore firestore = Firestore.instance;

  Future<List<Unit>> getUnitOf(Book book) async {
    QuerySnapshot result = await firestore.collection('books').where("book_id",isEqualTo: book.id).getDocuments();
    return result.documents.map((snapshot) => Unit.fromSnapshot(snapshot)).toList();
  }

  Future<List<Unit>> getEUnitOf(Book book) async {
    QuerySnapshot result = await firestore.collection('EnglishBook').document(book.docId).collection('units').orderBy('name').getDocuments();
    return result.documents.map((snapshot) => Unit.fromESnapshot(snapshot)).toList();
  }

}