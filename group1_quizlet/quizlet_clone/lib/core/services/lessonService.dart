import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/lesson.dart';
import 'package:quizlet_clone/core/repositories/lessonRepository.dart';

class LessonService {
  final LessonRepository repository;

  const LessonService({@required this.repository});

  Future<List<Lesson>> getLessons() async {
    return repository.getLessons();
  }

  Future<Lesson> getLessonById({@required String id}) async {
    return repository.getLessonById(id: id);
  }
}
