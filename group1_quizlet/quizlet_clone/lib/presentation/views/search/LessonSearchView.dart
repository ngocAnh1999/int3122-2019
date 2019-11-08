import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/services/SearchService.dart';
import 'package:quizlet_clone/presentation/views/home/LessonItem.dart';

class LessonSearchView extends StatefulWidget {
  final String keyword;

  LessonSearchView({@required this.keyword, Key key}) : super(key: key);

  @override
  _LessonSearchViewState createState() => _LessonSearchViewState();
}

class _LessonSearchViewState extends State<LessonSearchView> {
  @override
  Widget build(BuildContext context) {
    if (widget.keyword.isEmpty) {
      return Center(
        child: Text('Vui lòng nhập từ khóa'),
      );
    } else
      return FutureBuilder(
        future: SearchService.searchLesson(key: widget.keyword),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              var lessons = snapshot.data;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: new List<Widget>.from(lessons.map((lesson) {
                  return LessonItem(lesson: lesson);
                })),
              );
          }
          return null;
        },
      );
  }
}
