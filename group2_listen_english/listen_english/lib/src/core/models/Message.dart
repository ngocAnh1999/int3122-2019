enum TYPE {
  ZERO_HUMAN,
  ONE_HUMAN,
  TWO_HUMAN
}

class Message {
  String id;
  String text;
  String voice;
  TYPE type;

  Message({this.id,this.text,this.voice,this.type});

  Message.fromMap(Map snapshot,String id) :
        id = id ?? '',
        text = snapshot['text'] ?? '',
        voice = snapshot['voice'] ?? '',
        type = snapshot['type'] ?? '';

  toJson() {
    return {
      "id": id,
      "voice": voice,
      "text": text,
      "type": type,
    };
  }
}