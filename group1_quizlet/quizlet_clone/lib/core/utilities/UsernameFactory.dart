import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/services/UserService.dart';

class UsernameFactory {
  static const SPACE_CHAR = ' ';
  static const UNDER_SCORE_CHAR = '_';
  static final UserService _userService = UserService.instance;

  static Future<String> getUsername(
      {@required String firstName, @required String lastName}) async {
    final initialUsername = firstName
            .toLowerCase()
            .trim()
            .replaceAll(SPACE_CHAR, UNDER_SCORE_CHAR) +
        UNDER_SCORE_CHAR +
        lastName.toLowerCase().trim().replaceAll(SPACE_CHAR, UNDER_SCORE_CHAR);
    String buildUpUsername = initialUsername;
    int uniqueInteger = 1;
    while (await _userService.usernameExists(username: buildUpUsername)) {
      buildUpUsername = initialUsername + '$uniqueInteger';
      uniqueInteger++;
    }
    return buildUpUsername;
  }
}
