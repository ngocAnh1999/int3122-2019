import 'package:flutter/material.dart';
import 'package:mobile/core/models/Unit.dart';

class Book{
  String id;
  String name;
  String image;
  String description;

  List<Unit> lessons;

  Book({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
  });

  Map<String,String> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
  };

}