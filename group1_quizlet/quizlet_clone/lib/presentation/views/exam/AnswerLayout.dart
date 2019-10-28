import 'package:flutter/material.dart';

enum ExamType { ENTER_ANSWER, CHOOSE_BEST_ANSWER, TRUE_FALSE }

class AnswerLayout extends StatelessWidget {
  final ExamType examType;
  final String word;
  final String meaning;
  final String correctAnswer;
  final String userAnswer;

  AnswerLayout(
      {this.examType,
      this.word,
      this.meaning,
      this.correctAnswer,
      this.userAnswer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black26, width: 2)),
      child: Column(
        children: <Widget>[
          (examType == ExamType.TRUE_FALSE)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                      title: Text(word),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(),
                    ),
                    ListTile(
                      title: Text(meaning),
                    )
                  ],
                )
              : ListTile(
                  title: Text(word),
                ),
          (examType == ExamType.TRUE_FALSE)
              ? Container(
                  height: 60,
                )
              : Container(
                  height: 132,
                ),
          (correctAnswer == userAnswer)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        Text(
                          userAnswer,
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        Text(
                          correctAnswer,
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        Text(
                          (userAnswer.length > 25)
                              ? "${userAnswer.substring(0, 25)}..."
                              : userAnswer,
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
          Container(
            height: 12,
          ),
          (correctAnswer == userAnswer)
              ? Container(
                  decoration: BoxDecoration(color: Colors.green),
                  child: ListTile(
                    leading: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Đúng",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Sai",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
