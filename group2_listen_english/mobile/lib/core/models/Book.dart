import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/models/Unit.dart';

class Book {
  int id;
  String docId;
  String book_id;
  String name;
  String image;
  String description;

  List<Unit> lessons;

  Book({
    this.id,
    @required this.docId,
    @required this.book_id,
    @required this.name,
    @required this.image,
    @required this.description,
  });

  Map<String, dynamic> toJson() => {
        'book_id': book_id.toString(),
        'name': name,
        'image': image,
        'description': description,
      };

  Map<String, dynamic> toStrJson() => {
    'id': id,
    'docId': docId,
    'book_id': book_id.toString(),
    'name': name,
    'image': image,
    'description': description,
  };


  factory Book.fromMappedJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        docId: json['docId'],
        book_id: json['book_id'].toString(),
        name: json['name'],
        image: json['image'],
        description: json['description']);
  }

  factory Book.fromESnapshot(DocumentSnapshot snapshot) {
    return Book(
        docId: snapshot.documentID,
        book_id: snapshot.data['book_id'].toString(),
        name: snapshot.data['name'],
        image: snapshot.data['image'],
        description: snapshot.data['description']);
  }

  Book.fromSnapshot(DocumentSnapshot snapshot)
      : docId = snapshot.documentID,
        book_id = snapshot.data['book_id'].toString(),
        name = snapshot.data['name'],
        image = snapshot.data['image'],
        description = snapshot.data['description'];
}
