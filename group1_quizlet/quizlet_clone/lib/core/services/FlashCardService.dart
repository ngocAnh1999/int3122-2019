import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/repositories/FlashCardRepository.dart';
import 'package:quizlet_clone/core/repositories/strapi_implementations/FlashCardRepositoryStrapiImpl.dart';

class FlashCardService {
  static final FlashCardService instance =
      FlashCardService._(repository: new FlashCardRepositoryStrapiImpl());

  final FlashCardRepository repository;

  const FlashCardService._({@required this.repository});

  Future<List<FlashCard>> getFlashCards({@required lessonId}) async {
//    await Future.delayed(Duration(seconds: 3));
    return repository.getFlashCards(lessonId: lessonId);
  }

  Future<int> countFlashCards({@required lessonId}) async {
    return repository.countFlashCards(lessonId: lessonId);
  }
}
