import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/repository/LessonRepository.dart';
import 'package:flutter_app/domain/usecase/UseCase.dart';

class GetLessonsUseCase extends UseCaseWithoutParam<List<Lesson>> {
  final LessonRepository lessonRepository;

  GetLessonsUseCase({this.lessonRepository});

  @override
  List<Lesson> excute() {
    return lessonRepository.getLessons();
  }
}
