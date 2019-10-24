import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/lesson.dart';
import 'package:quizlet_clone/core/models/user.dart';
import 'package:quizlet_clone/core/repositories/implementations/userRepositoryImpl.dart';
import 'package:quizlet_clone/core/services/UserService.dart';
import 'package:quizlet_clone/presentation/views/lesson/LessonView.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  static final UserService _userService =
      new UserService(repository: new UserRepositoryImpl());

  LessonItem({Lesson lesson})
      : lesson = lesson,
        super(key: ObjectKey(lesson));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                lesson.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            ListTile(
              title: Text(
                "${lesson.numberOfFlashCards} thuật ngữ",
              ),
            ),
            ListTile(
              leading: FutureBuilder(
                future:
                    _userService.getFacebookAvatarUrl(userId: lesson.userId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return CircleAvatar(
                        child: Text('N',
                            style: TextStyle(
                                fontSize: 16, color: Colors.redAccent)),
                      );
                    case ConnectionState.done:
                      return CircleAvatar(
                        child: Image.network(snapshot.data.toString()),
                      );
                  }
                  return null;
                },
              ),
              title: FutureBuilder(
                future: _userService.getUser(id: lesson.userId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return Text('waiting');
                    case ConnectionState.done:
                      User user = snapshot.data;
                      return Text(user.username);
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonView(lesson: lesson)));
      },
    );
  }
}
