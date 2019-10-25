import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/models/User.dart';
import 'package:quizlet_clone/core/services/UserService.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';
import 'package:quizlet_clone/presentation/views/lesson/LessonView.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  static final UserService _userService = UserService.instance;

  LessonItem({@required this.lesson}) : super(key: ObjectKey(lesson));

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: FutureBuilder(
            future: _userService.getUser(id: lesson.userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Card(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case ConnectionState.done:
                  User user = snapshot.data;
                  return GestureDetector(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              lesson.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "${lesson.numberOfFlashCards} thuật ngữ",
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          FacebookProfileGetter.getAvatarUrl(
                                              facebookId: user.facebookId)))),
                            ),
                            title: Text(user.username),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LessonView(
                                    lesson: lesson,
                                    user: user,
                                  )));
                    },
                  );
              }
              return null;
            }));
  }
}
