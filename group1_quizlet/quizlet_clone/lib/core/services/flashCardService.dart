import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';
import 'package:quizlet_clone/core/repositories/flashCardRepository.dart';

class FlashCardService {
  final FlashCardRepository repository;

  FlashCardService({@required this.repository});

  Future<List<FlashCard>> getFlashCards({@required lessonId}) async {
    return repository.getFlashCards(lessonId);
  }
}
