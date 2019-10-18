import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';

class FlashCardRepository {
  final CollectionReference ref = Firestore.instance.collection('flashCards');

  Future<List<FlashCard>> getFlashCards(String lessonId) async {
    List<FlashCard> fcs;
    await ref.where('lessonId', isEqualTo: lessonId).getDocuments().then(
        (data) => fcs = data.documents
            .map((doc) => FlashCard.fromMap(doc.data, doc.documentID))
            .toList());
    return fcs;
  }

  Future<List<FlashCard>> getAllFlashCards() async {
    var result = await ref.getDocuments();
    List<FlashCard> fcs = result.documents
        .map((doc) => FlashCard.fromMap(doc.data, doc.documentID))
        .toList();
    return fcs;
  }
}
