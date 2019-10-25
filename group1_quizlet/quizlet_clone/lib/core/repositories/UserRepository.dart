import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/User.dart';

abstract class UserRepository {
  Future<User> getUser({@required String id});

  Future<void> addUser({@required Map data, @required String id});

  Future<bool> usernameExists({@required String username});

  Future<String> getFacebookAvatarUrl({@required String userId});
}
