import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/User.dart';
import 'package:quizlet_clone/core/repositories/UserRepository.dart';
import 'package:quizlet_clone/core/repositories/implementations/UserRepositoryImpl.dart';
import 'package:quizlet_clone/core/services/AuthService.dart';

class UserService {
  static final UserService instance =
      UserService._(repository: new UserRepositoryImpl());
  final UserRepository repository;

  const UserService._({@required this.repository});

  Future<User> getUser({@required String id}) async {
//    await Future.delayed(Duration(seconds: 3));
    return repository.getUser(id: id);
  }

  Future<void> addUser({@required Map data, @required String id}) {
    return repository.addUser(data: data, id: id);
  }

  Future<bool> usernameExists({@required String username}) {
    return repository.usernameExists(username: username);
  }

  Future<String> getFacebookAvatarUrl({@required String userId}) {
    return repository.getFacebookAvatarUrl(userId: userId);
  }

  Future<User> getCurrentUser() async {
    return getUser(id: (await AuthService.instance.getCurrentUser()).uid);
  }
}
