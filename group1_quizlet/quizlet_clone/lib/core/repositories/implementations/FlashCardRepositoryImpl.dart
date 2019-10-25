import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/repositories/FlashCardRepository.dart';

class FlashCardRepositoryImpl implements FlashCardRepository {
  final CollectionReference _ref = Firestore.instance.collection('flashCards');

  @override
  Future<List<FlashCard>> getFlashCards({@required String lessonId}) async {
    List<FlashCard> fcs;
    await _ref.where('lessonId', isEqualTo: lessonId).getDocuments().then(
        (data) => fcs = data.documents
            .map((doc) => FlashCard.fromMap(doc.data, doc.documentID))
            .toList());
    return fcs;
  }
}
