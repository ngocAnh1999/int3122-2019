import 'package:quizlet_clone/core/models/lesson.dart';
import 'package:quizlet_clone/core/repositories/lessonRepository.dart';

class LessonService {
  final LessonRepository repository = new LessonRepository();

  Future<List<Lesson>> getLessons() async {
    return repository.getLessons();
  }

  Future<Lesson> getLessonById(String id) async {
    return repository.getLessonById(id);
  }
}
