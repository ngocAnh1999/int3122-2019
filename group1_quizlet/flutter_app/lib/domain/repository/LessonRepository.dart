import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';

abstract class LessonRepository {
  List<Lesson> getLessons();
}
