import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';

abstract class FlashCardRepository {
  Future<List<FlashCard>> getFlashCards({@required String lessonId});
}
