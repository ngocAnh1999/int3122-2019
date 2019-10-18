import 'package:quizlet_clone/core/models/flashCard.dart';
import 'package:quizlet_clone/core/repositories/flashCardRepository.dart';

class FlashCardService {
  final FlashCardRepository repository = new FlashCardRepository();

  Future<List<FlashCard>> getFlashCards(String lessonId) {
    return repository.getFlashCards(lessonId);
  }

  Future<List<FlashCard>> getAllFlashCards() {
    return repository.getAllFlashCards();
  }
}
