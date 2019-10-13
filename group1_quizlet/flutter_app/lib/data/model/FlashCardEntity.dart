import 'package:flutter_app/data/mapper/Mapper.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';

class FlashCardEntity extends Mapper<FlashCard, FlashCardEntity> {
  final String word;
  final String meaning;

  FlashCardEntity({this.word, this.meaning});

  factory FlashCardEntity.fromJson(Map<String, dynamic> json) {
    return FlashCardEntity(
      word: json["word"],
      meaning: json["meaning"]
    );
  }

  @override
  FlashCardEntity mapToData(FlashCard domain) {
    return FlashCardEntity(
      word: domain.word,
      meaning: domain.meaning
    );
  }

  @override
  FlashCard mapToDomain(FlashCardEntity data) {
    return FlashCard(
      word: data.word,
      meaning: data.meaning
    );
  }
}