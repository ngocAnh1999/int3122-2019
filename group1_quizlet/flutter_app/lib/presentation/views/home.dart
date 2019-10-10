import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  LessonItem({Lesson lesson})
      : lesson = lesson,
        super(key: ObjectKey(lesson));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: Column(
          children: <Widget>[
            Text(
              lesson.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "${lesson.vocabs.length} thuật ngữ",
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                child: Text(lesson.title[0]),
              ),
              subtitle: Text("minmon98"),
            )
          ],
        ),
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
      children: widget.lessons.map((Lesson lesson) {
        return LessonItem(lesson: lesson,);
      }).toList(),
    );
  }
}
