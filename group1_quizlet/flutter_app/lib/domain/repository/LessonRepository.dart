import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/Vocabulary.dart';

abstract class LessonRepository {
  List<Lesson> getLessons();
}