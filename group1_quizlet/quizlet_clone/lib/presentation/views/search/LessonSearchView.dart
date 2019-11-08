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
    final _textStyle = TextStyle(
        fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold);
    if (widget.keyword.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
                title: Center(
              child: Text(
                "Nhập một chủ đề hoặc từ khoá",
                style: _textStyle,
              ),
            )),
            ListTile(
              title: Center(
                child: Text(
                  "Mẹo: Càng cụ thể càng tốt",
                  style: _textStyle,
                ),
              ),
            )
          ],
        ),
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
