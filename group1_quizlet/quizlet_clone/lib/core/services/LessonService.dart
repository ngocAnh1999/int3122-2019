import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/repositories/LessonRepository.dart';
import 'package:quizlet_clone/core/repositories/strapi_implementations/LessonRepositoryStrapiImpl.dart';

class LessonService {
  static final LessonService instance =
      LessonService._(repository: new LessonRepositoryStrapiImpl());
  final LessonRepository repository;

  const LessonService._({@required this.repository});

  Future<List<Lesson>> getLessons() async {
    return repository.getLessons();
  }

  Future<Lesson> getLessonById({@required String id}) async {
    return repository.getLessonById(id: id);
  }

  Future<List<Lesson>> getLessonsByUser({@required String username}) async {
    return repository.getLessonsByUser(username: username);
  }
}
