import 'package:flutter/material.dart';
import 'package:mobile/core/models/Conversation.dart';

class Unit {
  int point;
  String name;
  int level;

  List<Conversation> conversations;

  Unit({
    @required this.name,
    this.point,
    this.level,
  });

  Map<String, dynamic> toJson() => {
        'point': point,
        'name': name,
        'level': level,
      };
}
