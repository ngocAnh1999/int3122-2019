
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Conversation {
  String docId;
  String convId;
  int id;
  String name;
  String audio;

  Conversation({
    @required this.convId,
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

  factory Conversation.fromMappedJson(Map<String,dynamic> json) {
    return Conversation(
      id: json['id'] as int,
      name: json['name'] as String,
      convId: json['connId'] as String,
      audio: json['audio'] as String
    );
  }
}