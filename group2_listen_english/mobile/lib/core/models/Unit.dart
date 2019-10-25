import 'package:flutter/material.dart';

class Unit {
  int point;
  String name;
  int level;

  Unit({
    @required this.name,
    this.point,
    this.level,

});

  Map<String,dynamic> toJson() => {
    'point': point,
    'name': name,
    'level': level,
  };

}