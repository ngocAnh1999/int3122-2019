import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/services/LessonService.dart';

import 'LessonItem.dart';

class LessonList extends StatefulWidget {
  LessonList({Key key}) : super(key: key);

  @override
  LessonListState createState() => new LessonListState();
}

class LessonListState extends State<LessonList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LessonService.instance.getLessons(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return CircularProgressIndicator();
          case ConnectionState.done:
            var lessons = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: new List<Widget>.from(lessons.map((Lesson lesson) {
                return LessonItem(lesson: lesson);
              }).toList()),
            );
        }
        return null;
      },
    );
  }
}
