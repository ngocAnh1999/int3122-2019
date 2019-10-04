import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/Vocabulary.dart';

abstract class LessonRepository {
  Lesson createLesson(String title, List<Vocabulary> newWord);
  bool isExist(String title);
  List<Lesson> getLessons();
}