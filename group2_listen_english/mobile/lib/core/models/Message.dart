import 'TimeCustom.dart';

enum TYPE { ZERO_HUMAN, ONE_HUMAN, TWO_HUMAN }

class Message {
  int id;
  String text;
  Time starttime;
  Time endtime;
  String character;
  TYPE type;

  Message({this.id, this.text, this.starttime, this.endtime, this.character, this.type});

  Message.fromMap(Map snapshot, int id)
      : id = id ?? '',
        text = snapshot['text'] ?? '',
        starttime = snapshot['starttime'] ?? '',
        endtime = snapshot['endtime'] ?? '',
        character = snapshot['character'] ?? '',
        type = snapshot['type'] ?? '';

  toJson() {
    return {
      "id": id,
      "text": text,
      "starttime": starttime,
      "endtime": endtime,
      "character": character,
      "type": type,
    };
  }
}
