import 'package:flutter_app/data/api/APIDataSource.dart';
import 'package:flutter_app/data/model/LessonEntity.dart';
import 'package:flutter_app/data/model/FlashCardEntity.dart';
import 'package:flutter_app/domain/model/Lesson.dart';

void main() {
  LessonEntity abc = new LessonEntity(
    title: "ABC",
    description: "BCD",
    vocabs: <VocabularyEntity>[
      VocabularyEntity(word: "a", meaning: "a"),
      VocabularyEntity(word: "b", meaning: "b"),
      VocabularyEntity(word: "c", meaning: "c"),
    ]
  );
  print(abc.title);
  print(abc.description);
  print(abc.vocabs);
  Lesson bcd = abc.mapToDomain(abc);
  print(bcd.title);
  print(bcd.description);
  print(bcd.vocabs);
  APIDataSource apiDataSource = new APIDataSource();
  print(apiDataSource.getLessons());
}