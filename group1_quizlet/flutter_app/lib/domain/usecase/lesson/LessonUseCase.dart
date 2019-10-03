import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/repository/LessonRepository.dart';
import 'package:flutter_app/domain/usecase/UseCase.dart';

class LessonUseCase extends UseCaseWithoutParam<List<Lesson>> {
  final LessonRepository lessonRepository;

  LessonUseCase(this.lessonRepository);

  @override
  List<Lesson> excute() {
    return lessonRepository.getLessons();
  }
}