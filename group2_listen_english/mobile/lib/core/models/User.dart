import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String id;
  final String email;
  final String ava_url;

  User({this.name, this.ava_url, this.email, this.id});

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'ava_url': ava_url
    };
  }

  factory User.fromJson(Map<String, dynamic> doc){
    User user = new User(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      ava_url: doc['ava_url'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc){
    return User.fromJson(doc.data);
  }

  factory User.fromMappedJson(Map<String,String> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['email']
    );
  }
}
