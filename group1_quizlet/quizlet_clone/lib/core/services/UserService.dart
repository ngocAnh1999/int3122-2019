import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/user.dart';
import 'package:quizlet_clone/core/repositories/userRepository.dart';

class UserService {
  final UserRepository repository;

  const UserService({@required this.repository});

  Future<User> getUser({@required String id}) {
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
}
