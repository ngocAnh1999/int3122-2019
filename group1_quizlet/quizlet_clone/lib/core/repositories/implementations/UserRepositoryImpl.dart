import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/User.dart';
import 'package:quizlet_clone/core/repositories/UserRepository.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';

class UserRepositoryImpl implements UserRepository {
  final CollectionReference _ref = Firestore.instance.collection('users');

  @override
  Future<void> addUser({@required Map data, @required String id}) async {
    await _ref.document(id).setData(data);
  }

  @override
  Future<User> getUser({@required String id}) async {
    var user;
    await _ref.document(id).get().then((doc) {
      if (doc.data != null) user = User.fromMap(doc.data, doc.documentID);
    });
    return user;
  }

  @override
  Future<bool> usernameExists({@required String username}) async {
    var result =
        await _ref.where('username', isEqualTo: username).getDocuments();
    return result.documents.isNotEmpty;
  }

  @override
  Future<String> getFacebookAvatarUrl({@required String userId}) async {
    var doc = await _ref.document(userId).get();
    return FacebookProfileGetter.getAvatarUrl(
        facebookId: doc.data['facebookId']);
  }
}
