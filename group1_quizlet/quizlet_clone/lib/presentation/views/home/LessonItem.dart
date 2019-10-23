import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/lesson.dart';
import 'package:quizlet_clone/presentation/views/lesson/LessonView.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;

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
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/profile.jpg"),
              ),
              title: Text("minmon98"),
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
