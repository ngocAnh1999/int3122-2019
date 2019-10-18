import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId;
  String ggId;
  String email;
  String name;
  String status;
  String createdAt;
  String avatarUrl;

  User({this.userId, this.ggId, this.email, this.name, this.status, this.createdAt, this.avatarUrl});

  factory User.fromSnapshot(DocumentSnapshot snapshot){
    print(snapshot);
    return User(
      userId : snapshot.documentID,
      ggId : snapshot.data['id'],
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      createdAt:  snapshot.data['created_at'],
      status: snapshot.data['status'],
      avatarUrl: snapshot.data['avatar_url']
    );
  }
}