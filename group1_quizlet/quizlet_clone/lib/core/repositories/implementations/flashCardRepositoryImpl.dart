import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';
import 'package:quizlet_clone/core/repositories/flashCardRepository.dart';

class FlashCardRepositoryImpl implements FlashCardRepository {
  final CollectionReference ref = Firestore.instance.collection('flashCards');

  @override
  Future<List<FlashCard>> getFlashCards(String lessonId) async {
    List<FlashCard> fcs;
    await ref.where('lessonId', isEqualTo: lessonId).getDocuments().then(
        (data) => fcs = data.documents
            .map((doc) => FlashCard.fromMap(doc.data, doc.documentID))
            .toList());
    return fcs;
  }
}
