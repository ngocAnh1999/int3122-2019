import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/repositories/LessonRepository.dart';
import 'package:quizlet_clone/core/repositories/implementations/LessonRepositoryImpl.dart';

class LessonService {
  static final LessonService instance =
      LessonService._(repository: new LessonRepositoryImpl());
  final LessonRepository repository;

  const LessonService._({@required this.repository});

  Future<List<Lesson>> getLessons() async {
    return repository.getLessons();
  }

  Future<Lesson> getLessonById({@required String id}) async {
    return repository.getLessonById(id: id);
  }
}
