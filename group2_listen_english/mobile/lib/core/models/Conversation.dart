
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Conversation {
  String docId;
  String unit_id;
  String id;
  String name;
  String audio;

  Conversation({
    @required this.unit_id,
    @required this.docId,
    @required this.id,
    @required this.name,
    @required this.audio,
  });

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'audio': audio
  };

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot) {
    return Conversation(
      docId: snapshot.documentID,
      id: snapshot.data['id'],
      unit_id: snapshot.data['unit_id'],
      name: snapshot.data['name'],
      audio: snapshot.data['audio']
    );

  }

  factory Conversation.fromESnapshot(DocumentSnapshot snapshot) {
    return Conversation(
      docId: snapshot.documentID,
      id: snapshot.data['id'],
      name: snapshot.data['name'],
      audio: snapshot.data['audio']
    );
  }
}