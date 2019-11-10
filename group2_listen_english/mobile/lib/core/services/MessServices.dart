import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Conversation.dart';
import 'package:mobile/core/models/Mess.dart';
import 'package:mobile/core/models/Unit.dart';

class MessServices {
  final Firestore firestore = Firestore.instance;
  Future<List<Mess>> getEMess(Book book, Unit unit, Conversation conversation) async {
    QuerySnapshot result = await firestore.collection('EnglishBook/' + book.docId +
        '/units/' + unit.docId +
        '/conversations/' + conversation.docId +
        '/messages').orderBy('order').getDocuments();
    return result.documents.map((snapshot) => Mess.fromEMessage(snapshot)).toList();
  }


}