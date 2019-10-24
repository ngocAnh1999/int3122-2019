import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/repositories/FlashCardRepository.dart';
import 'package:quizlet_clone/core/repositories/implementations/FlashCardRepositoryImpl.dart';

class FlashCardService {
  static final FlashCardService instance =
      FlashCardService._(repository: new FlashCardRepositoryImpl());

  final FlashCardRepository repository;

  const FlashCardService._({@required this.repository});

  Future<List<FlashCard>> getFlashCards({@required lessonId}) async {
//    await Future.delayed(Duration(seconds: 3));
    return repository.getFlashCards(lessonId: lessonId);
  }
}
