import 'package:listen_english/src/core/models/Message.dart';

class Lesson {
  String id;
  int point;
  String name;
  int level;
  List<Message> conversations;

  Lesson({this.id,this.point,this.name,this.level,this.conversations});

}