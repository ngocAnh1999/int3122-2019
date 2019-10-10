import 'package:flutter_app/data/model/LessonEntity.dart';
import 'package:flutter_app/data/model/VocabularyEntity.dart';

class Constant {
  static final List<LessonEntity> lessons = <LessonEntity>[
    LessonEntity(
        title: "Animal",
        description: "List of animal words",
        vocabs: <VocabularyEntity>[
          VocabularyEntity(word: "dog", meaning: "chó"),
          VocabularyEntity(word: "cat", meaning: "mèo"),
          VocabularyEntity(word: "duck", meaning: "vịt")
        ]),
    LessonEntity(
        title: "Fruit",
        description: "List of fruit words",
        vocabs: <VocabularyEntity>[
          VocabularyEntity(word: "apple", meaning: "táo"),
          VocabularyEntity(word: "orange", meaning: "cam"),
          VocabularyEntity(word: "banana", meaning: "chuối"),
          VocabularyEntity(word: "mango", meaning: "xoài")
        ]),
  ];
}
