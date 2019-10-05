import 'package:flutter_app/domain/model/Vocabulary.dart';

class Lesson {
  final String title;
  final String description;
  final List<Vocabulary> vocabs;

  Lesson({this.title, this.description, this.vocabs});
}
