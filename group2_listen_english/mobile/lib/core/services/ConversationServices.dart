import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Conversation.dart';
import 'package:mobile/core/models/Unit.dart';

class ConversationServices {
  final Firestore firestore = Firestore.instance;
  Future<List<Conversation>> getConversationsOf(Unit unit) async {
    QuerySnapshot result = await firestore.collection('conversations').where('unit_id', isEqualTo: unit.id).getDocuments();
    return result.documents.map((snapshot) => Conversation.fromSnapshot(snapshot)).toList();
  }

  Future<List<Conversation>> getEConversationOf(Book book,Unit unit) async {
    QuerySnapshot result = await firestore.collection('EnglishBook').document(book.docId).collection('units').document(unit.docId).collection('conversations').getDocuments();
    return result.documents.map((snapshot) => Conversation.fromESnapshot(snapshot)).toList();
  }

}