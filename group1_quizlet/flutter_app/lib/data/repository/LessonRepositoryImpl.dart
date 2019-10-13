import 'package:flutter_app/data/api/APIDataSource.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/repository/LessonRepository.dart';

class LessonRepositoryImpl extends LessonRepository {
  final APIDataSource apiDataSource = new APIDataSource();

  List<Lesson> getLessons() {
    return apiDataSource.getLessons();
  }
}
