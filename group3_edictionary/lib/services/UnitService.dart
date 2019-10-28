import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Unit.dart';

class UnitService {
  Future<List<Unit>> findUnitsByBookId(int bookId) async {
    QuerySnapshot result = await Firestore.instance
      .collection('units')
      .where('book_id', isEqualTo: bookId)
      .orderBy('number')
      .getDocuments();
    return result.documents.map((snapshot) => Unit.fromSnapshot(snapshot)).toList();
  }
}