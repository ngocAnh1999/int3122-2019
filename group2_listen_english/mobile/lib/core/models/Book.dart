import 'package:flutter/material.dart';
import 'package:mobile/core/models/Unit.dart';

class Book{
  String id;
  String name;
  String image;

  List<Unit> lessons;

//  Book({this.id,this.name,this.image,this.rating,this.description});

  Book({
    @required this.id,
    @required this.name,
    @required this.image,
  });

  Map<String,String> toJson() => {
    'id': id,
    'name': name,
    'image': image,
  };

  Book.fromMappedJson(Map<String,dynamic> json):
      id = json['id'],
      name = json['name'],
      image = json['image'];

}