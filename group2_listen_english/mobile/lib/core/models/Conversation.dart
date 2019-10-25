
import 'package:flutter/material.dart';

class Conversation {
  int id;
  String name;
  String audio;

  Conversation({
    @required this.id,
    @required this.name,
    @required this.audio,
  });

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'audio': audio
  };
}