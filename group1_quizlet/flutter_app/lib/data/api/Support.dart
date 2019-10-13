import 'package:flutter_app/data/model/LessonEntity.dart';
import 'package:flutter_app/data/model/FlashCardEntity.dart';

class Constant {
  static final List<LessonEntity> lessons = <LessonEntity>[
    LessonEntity(
        title: "Animal",
        description: "List of animal words",
        vocabs: <FlashCardEntity>[
          FlashCardEntity(word: "dog", meaning: "chó"),
          FlashCardEntity(word: "cat", meaning: "mèo"),
          FlashCardEntity(word: "duck", meaning: "vịt")
        ]),
    LessonEntity(
        title: "Fruit",
        description: "List of fruit words",
        vocabs: <FlashCardEntity>[
          FlashCardEntity(word: "apple", meaning: "táo"),
          FlashCardEntity(word: "orange", meaning: "cam"),
          FlashCardEntity(word: "banana", meaning: "chuối"),
          FlashCardEntity(word: "mango", meaning: "xoài")
        ]),
  ];
}
