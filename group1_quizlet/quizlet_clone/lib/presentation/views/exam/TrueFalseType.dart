import 'package:flutter/material.dart';
import 'package:quizlet_clone/presentation/views/exam/AnswerCallback.dart';

class TrueFalseType extends StatefulWidget {
  final String word;
  final String meaning;
  final bool answer;
  final AnswerCallback answerCallback;

  TrueFalseType(
      {Key key, this.word, this.meaning, this.answer, this.answerCallback})
      : super(key: key);

  @override
  TrueFalseState createState() => new TrueFalseState();
}

class TrueFalseState extends State<TrueFalseType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              widget.word,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Divider(
              thickness: 3,
            ),
          ),
          ListTile(
            title: Text(
              widget.meaning,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                color: Colors.cyan,
                child: Text(
                  "Đúng",
                  style: TextStyle(fontSize: 16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                onPressed: () {
                  widget.answerCallback("Đúng", true == widget.answer);
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.cyan,
                child: Text(
                  "Sai",
                  style: TextStyle(fontSize: 16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                onPressed: () {
                  widget.answerCallback("Sai", false == widget.answer);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
