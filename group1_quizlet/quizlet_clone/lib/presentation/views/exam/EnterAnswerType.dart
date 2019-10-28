import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/presentation/views/exam/AnswerCallback.dart';

class EnterAnswerType extends StatefulWidget {
  final FlashCard flashCard;
  final AnswerCallback answerCallback;

  EnterAnswerType({Key key, this.flashCard, this.answerCallback})
      : super(key: key);

  @override
  EnterAnswerTypeState createState() => new EnterAnswerTypeState();
}

class EnterAnswerTypeState extends State<EnterAnswerType> {
  final myEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              widget.flashCard.word,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 20,
          ),
          Theme(
            data: ThemeData(primaryColor: Colors.yellow),
            child: TextFormField(
              controller: myEditingController,
              onEditingComplete: () {
                var answer = myEditingController.value.text;
                widget.answerCallback(
                    answer,
                    answer.toLowerCase() ==
                        widget.flashCard.meaning.toLowerCase());
                myEditingController.clear();
              },
              decoration: InputDecoration(
                  helperStyle: TextStyle(fontSize: 15),
                  helperText: "Nhập đáp án",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 2),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      widget.answerCallback("", false);
                      myEditingController.clear();
                    },
                    child: Text(
                      "Tôi không biết",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
