import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/models/Unit.dart';

class Book{
  String docId;
  int id;
  String name;
  String image;
  String description;

  List<Unit> lessons;

  Book({
    @required this.docId,
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
  });

  Book.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        image = data['image'],
        description = data['description'];

  Map<String,dynamic> toJson() => {
    'book_id': id,
    'name': name,
    'image': image,
    'description': description,
  };

  Book.fromMappedJson(Map<String,dynamic> json):
      id = json['id'],
      name = json['name'],
      image = json['image'];

  factory Book.fromSnapshot(DocumentSnapshot snapshot) {
    return Book(
      docId: snapshot.documentID,
      id: snapshot.data['book_id'],
      name: snapshot.data['name'],
      image: snapshot.data['img_name'],
      description: "An English Book"
    );
  }

  factory Book.fromESnapshot(DocumentSnapshot snapshot) {
    return Book(
        docId: snapshot.documentID,
        id: snapshot.data['book_id'],
        name: snapshot.data['name'],
        image: snapshot.data['image'],
        description: snapshot.data['description']
    );
  }

}