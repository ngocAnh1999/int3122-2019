import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessons();

  Future<Lesson> getLessonById({@required String id});
}
