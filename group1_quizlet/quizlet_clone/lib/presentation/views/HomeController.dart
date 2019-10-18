import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/lesson.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/presentation/views/LessonController.dart';

class LessonItem extends StatelessWidget {
  final Lesson lesson;
  final Future<List<FlashCard>> flashCards;

  LessonItem({Lesson lesson, Future<List<FlashCard>> flashCards})
      : lesson = lesson,
        flashCards = flashCards,
        super(key: ObjectKey(lesson));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: flashCards,
        builder: (context, snapshot) {
          List<FlashCard> data = snapshot.data;
          return GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      lesson.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "${data.length} thuật ngữ",
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
                      builder: (context) => LessonView(
                            lesson: lesson,
                        flashCards: data
                          )));
            },
          );
        });
  }
}

class LessonList extends StatefulWidget {
  final Future<List<Lesson>> lessons;
  final FlashCardService flashCardService = new FlashCardService();

  LessonList({Key key, this.lessons}) : super(key: key);

  @override
  LessonListState createState() => new LessonListState();
}

class LessonListState extends State<LessonList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.lessons,
        builder: (BuildContext context, AsyncSnapshot<List<Lesson>> snapshot) {
          List<Lesson> data = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: data.map((Lesson lesson) {
              return LessonItem(
                lesson: lesson,
                flashCards: widget.flashCardService.getFlashCards(lesson.id),
              );
            }).toList(),
          );
        });
  }
}
