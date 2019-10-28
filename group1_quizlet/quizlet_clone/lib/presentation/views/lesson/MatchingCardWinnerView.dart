import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';

import 'MatchingCardView.dart';

class MatchingCardWinnerView extends StatelessWidget {
  final int falseAttempts;
  final Lesson lesson;

  MatchingCardWinnerView({@required this.falseAttempts, @required this.lesson})
      : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Chúc mừng'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Số lần ghép sai: $falseAttempts'),
            ),
            Container(
                width: 150,
                height: 60,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: Colors.blueAccent,
                    highlightColor: Colors.deepPurple,
                    child: Center(
                      child: Text('Chơi lại',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MatchingCardView(lesson: this.lesson))))),
          ],
        ),
      ),
    );
  }
}
