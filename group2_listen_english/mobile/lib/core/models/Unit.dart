import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/models/Conversation.dart';

class Unit {
  String docId;
  int id;
  String point;
  String name;
  String level;

  Unit({
    @required this.docId,
    this.id,
    @required this.name,
    this.point,
    this.level,
  });

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'id': id,
        'point': point,
        'name': name,
        'level': level,
      };

  Map<String, dynamic> toStrJson(int book_id) => {
        'docId': docId,
        'name': name,
        'book': book_id.toString(),
        'level': level,
        'point': point,
      };

  factory Unit.fromESnapshot(DocumentSnapshot snapshot) {
    return Unit(
        docId: snapshot.documentID,
        level: snapshot.data['level'].toString(),
        name: snapshot.data['name'],
        point: snapshot.data['point'].toString(),
    );
  }

  factory Unit.fromMappedJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] as int,
      docId: json['docId'] as String,
      name: json['name'] as String,
      level: json['level'] as String,
      point: json['point'] as String,
    );
  }
}
