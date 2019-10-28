import 'package:flutter/material.dart';
import 'package:quizlet_clone/presentation/views/exam/AnswerCallback.dart';

class ChooseBestAnswerQuestion extends StatefulWidget {
  final String meaning;
  final List<String> words;
  final String answer;
  final AnswerCallback answerCallback;

  ChooseBestAnswerQuestion(
      {Key key, this.meaning, this.words, this.answer, this.answerCallback})
      : super(key: key);

  @override
  ChooseBestAnswerQuestionState createState() => new ChooseBestAnswerQuestionState();
}

class ChooseBestAnswerQuestionState extends State<ChooseBestAnswerQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(widget.meaning,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.words.map((String word) {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.cyan),
                          textColor: Colors.cyan,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(word, style: TextStyle(color: Colors.cyan, fontSize: 16),),
                          ),
                          onPressed: () {
                            widget.answerCallback(word, word == widget.answer);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
