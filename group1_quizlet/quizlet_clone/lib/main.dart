import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/core/services/lessonService.dart';
import 'core/models/lesson.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LessonService lessonService = new LessonService();
    final FlashCardService flashCardService = new FlashCardService();
    Future<List<Lesson>> lessons = lessonService.getLessons();
    Future<List<FlashCard>> fcs =
        flashCardService.getFlashCards("P5lcSBXVaVYl0kGDPxrl");
    return Container(
      child: FutureBuilder<List<FlashCard>>(
        future: fcs,
        builder:
            (BuildContext context, AsyncSnapshot<List<FlashCard>> snapshot) {
          var data = snapshot.data;
          return new Directionality(
            child: Text('length: ${data[0].meaning}'),
            textDirection: TextDirection.ltr,
          );
        },
      ),
    );
  }
}
