import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  LessonItem({Lesson lesson})
      : lesson = lesson,
        super(key: ObjectKey(lesson));

  @override
  Widget build(BuildContext context) {
    return Card(
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
              "${lesson.vocabs.length} thuật ngữ",
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
    );
  }
}

class LessonList extends StatefulWidget {
  final List<Lesson> lessons;
  LessonList({Key key, this.lessons}) : super(key: key);
  @override
  LessonListState createState() => new LessonListState();
}

class LessonListState extends State<LessonList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: widget.lessons.map((Lesson lesson) {
        return LessonItem(
          lesson: lesson,
        );
      }).toList(),
    );
  }
}
