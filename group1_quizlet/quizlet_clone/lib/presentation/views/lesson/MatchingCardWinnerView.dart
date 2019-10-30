import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';

import 'MatchingCardView.dart';

class MatchingCardWinnerView extends StatelessWidget {
  final int falseAttempts;
  final Lesson lesson;
  final int time;

  MatchingCardWinnerView(
      {@required this.falseAttempts,
      @required this.lesson,
      @required this.time})
      : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text('Kết quả',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text(
                "${time} giây",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                'Số lần ghép sai: $falseAttempts',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                '💪💪💪',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              color: Colors.cyan,
              textColor: Colors.white,
              child: Text('Chơi lại', style: TextStyle(fontSize: 18)),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MatchingCardView(lesson: this.lesson)))),
        ],
      ),
    );
  }
}
