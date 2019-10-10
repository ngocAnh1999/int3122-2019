import 'package:listen_english/src/core/models/Lesson.dart';

class Book{
  String id;
  String name;
  String image;
  String rating;
  String description;

  List<Lesson> lessons;

  Book({this.id,this.name,this.image,this.rating,this.description});

}