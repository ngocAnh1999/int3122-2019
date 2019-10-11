import 'package:flutter_app/data/mapper/Mapper.dart';
import 'package:flutter_app/data/model/FlashCardEntity.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';

class LessonEntity extends Mapper<Lesson, LessonEntity> {
  final String title;
  final String description;
  final List<FlashCardEntity> vocabs;

  LessonEntity({this.title, this.description, this.vocabs});

  factory LessonEntity.fromJson(Map<String, dynamic> json) {
    return LessonEntity(
        title: json["title"],
        description: json["description"],
        vocabs: json["vocabs"]);
  }

  @override
  LessonEntity mapToData(Lesson domain) {
    return LessonEntity(
        title: domain.title,
        description: domain.description,
        vocabs: domain.vocabs.map((FlashCard vocabulary) {
          return FlashCardEntity(
              word: vocabulary.word, meaning: vocabulary.meaning);
        }).toList());
  }

  @override
  Lesson mapToDomain(LessonEntity data) {
    return Lesson(
        title: data.title,
        description: data.description,
        vocabs: data.vocabs.map((FlashCardEntity vocabularyEntity) {
          return FlashCard(
              word: vocabularyEntity.word, meaning: vocabularyEntity.meaning);
        }).toList());
  }
}
