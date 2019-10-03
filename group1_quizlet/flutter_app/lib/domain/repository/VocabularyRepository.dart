import 'package:flutter_app/domain/model/Vocabulary.dart';

abstract class VocabularyRepository {
  List<Vocabulary> getVocabularies(String title);
}