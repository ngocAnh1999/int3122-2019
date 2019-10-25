import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';

abstract class FlashCardRepository {
  Future<List<FlashCard>> getFlashCards({@required String lessonId});
}
