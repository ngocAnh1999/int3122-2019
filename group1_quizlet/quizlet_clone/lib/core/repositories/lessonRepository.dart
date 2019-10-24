import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/lesson.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessons();

  Future<Lesson> getLessonById({@required String id});
}
