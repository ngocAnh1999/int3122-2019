import 'package:flutter/material.dart';
import 'package:quizlet_clone/presentation/views/exam/AnswerCallback.dart';

class ChooseBestAnswerType extends StatefulWidget {
  final String meaning;
  final List<String> words;
  final String anwers;
  final AnswerCallback answerCallback;

  ChooseBestAnswerType(
      {Key key, this.meaning, this.words, this.anwers, this.answerCallback})
      : super(key: key);

  @override
  ChooseBestAnswerTypeState createState() => new ChooseBestAnswerTypeState();
}

class ChooseBestAnswerTypeState extends State<ChooseBestAnswerType> {
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
                            widget.answerCallback(word, word == widget.anwers);
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
