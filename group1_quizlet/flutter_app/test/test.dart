import 'package:flutter_app/data/api/APIDataSource.dart';
import 'package:flutter_app/data/model/LessonEntity.dart';
import 'package:flutter_app/data/model/FlashCardEntity.dart';
import 'package:flutter_app/domain/model/Lesson.dart';

void main() {
  LessonEntity abc = new LessonEntity(
    title: "ABC",
    description: "BCD",
    vocabs: <FlashCardEntity>[
      FlashCardEntity(word: "a", meaning: "a"),
      FlashCardEntity(word: "b", meaning: "b"),
      FlashCardEntity(word: "c", meaning: "c"),
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