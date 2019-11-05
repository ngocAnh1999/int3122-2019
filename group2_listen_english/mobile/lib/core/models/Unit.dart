import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/models/Conversation.dart';

class Unit {
  String docId;
  String book_id;
  String id;
  int point;
  String name;
  int level;

  Unit({
    @required this.docId,
    @required this.book_id,
    @required this.id,
    @required this.name,
    this.point,
    this.level,
  });

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'book_id': book_id,
        'id': id,
        'point': point,
        'name': name,
        'level': level,
  };

  factory Unit.fromSnapshot(DocumentSnapshot snapshot) {
    return Unit(
      docId: snapshot.documentID,
      book_id: snapshot.data['book_id'].toString(),
      id: snapshot.data['id'],
      name: snapshot.data['name'],
    );
  }

  factory Unit.fromESnapshot(DocumentSnapshot snapshot) {
    return Unit(
      docId: snapshot.documentID,
      level: snapshot.data['level'],
      name: snapshot.data['name'],
      point: snapshot.data['point']
    );
  }
}
