import 'package:quizlet_clone/core/models/flashCard.dart';

abstract class FlashCardRepository {
  Future<List<FlashCard>> getFlashCards(String lessonId);
}