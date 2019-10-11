import 'package:flutter_app/data/mapper/Mapper.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';

class VocabularyEntity extends Mapper<Vocabulary, VocabularyEntity> {
  final String word;
  final String meaning;

  VocabularyEntity({this.word, this.meaning});

  factory VocabularyEntity.fromJson(Map<String, dynamic> json) {
    return VocabularyEntity(
      word: json["word"],
      meaning: json["meaning"]
    );
  }

  @override
  VocabularyEntity mapToData(Vocabulary domain) {
    return VocabularyEntity(
      word: domain.word,
      meaning: domain.meaning
    );
  }

  @override
  Vocabulary mapToDomain(VocabularyEntity data) {
    return Vocabulary(
      word: data.word,
      meaning: data.meaning
    );
  }
}