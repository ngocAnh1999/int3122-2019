
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum TYPE { ZERO_HUMAN, ONE_HUMAN, TWO_HUMAN }

class Mess {
  int order;
  String text;
  String start;
  String end;
  String character;
  TYPE type;

  Mess({
    @required this.text,
    @required this.end,
    @required this.start,
    @required this.type,
    @required this.order,
    @required this.character
  });

  Map<String,dynamic> toJson() {
    return {
      "text": text,
      "start": start,
      "end": end,
      "character": character,
      "order": order
    };
  }

  factory Mess.fromEMessage(DocumentSnapshot snapshot){
    return Mess(
      text: snapshot.data['text'],
      order: snapshot.data['order'],
      start: snapshot.data['start'],
      end: snapshot.data['end'],
      character: snapshot.data['character']
    );
  }

  double getStart(){
    return double.parse(this.start);
  }

  double getEnd(){
    return double.parse(this.end);
  }

}