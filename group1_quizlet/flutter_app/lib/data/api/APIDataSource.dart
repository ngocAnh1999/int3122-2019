import 'package:flutter_app/data/api/Support.dart';
import 'package:flutter_app/data/model/LessonEntity.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/repository/LessonRepository.dart';

class APIDataSource extends LessonRepository {
  List<Lesson> getLessons() {
    return Constant.lessons.map((LessonEntity lesson) {
      return lesson.mapToDomain(lesson);
    }).toList();
  }
}