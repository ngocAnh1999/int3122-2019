import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/presentation/views/writing/WritingActivityResult.dart';

const String SUGGEST_ANSWER_TITLE = "Đáp án đúng";
const String YOUR_ANSWER_TITLE = "Đáp án của bạn";
const String ENTER_ANSWER_TITLE = "Nhập tiếng anh vào đây";
const String ENTER_CORRECT_ANSWERS_TITLE = "Chép lại đáp án đúng";
const String CORRECT_ANSWER = "Đáp án đúng";

class WritingActivity extends StatefulWidget {
  final Lesson lesson;
  final List<FlashCard> flashCards;

  WritingActivity({Key key, this.lesson, this.flashCards}) : super(key: key);

  @override
  WritingActivityState createState() => new WritingActivityState();
}

class WritingActivityState extends State<WritingActivity> {
  final _myEditingController = TextEditingController();
  Color _textFieldBorderColor = Colors.yellow;
  Color _helperTextColor = Colors.black54;

  int _currentFlashCardIndex = 0;
  String _answer;
  String _textFieldHelperText = ENTER_ANSWER_TITLE;
  var _numberOfIncorrectAttempts;
  var _numberOfAttempts = 0;
  bool _suffixIconVisible = true;
  bool _correctAnswer = false;

  @override
  void initState() {
    super.initState();
    _numberOfIncorrectAttempts = List.filled(widget.flashCards.length, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 70 / 100,
            lineHeight: 20.0,
            center: Text(
                "${((_currentFlashCardIndex / widget.flashCards.length) * 100).toStringAsFixed(0)}%"),
            percent: _currentFlashCardIndex / widget.flashCards.length,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
          leading: IconButton(
            color: Colors.black54,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            ListTile(
              title: Text(
                widget.flashCards[_currentFlashCardIndex].meaning,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: keyboardIsVisible(),
                child: Center(
                  child: (_answer == null)
                      ? null
                      : Column(
                          children: <Widget>[
                            (_answer.isEmpty)
                                ? Padding(
                                    padding: EdgeInsets.all(0),
                                  )
                                : ListTile(
                                    title: Text(
                                      YOUR_ANSWER_TITLE,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    subtitle: Text(
                                      _answer,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  ),
                            ListTile(
                              title: Text(
                                SUGGEST_ANSWER_TITLE,
                                style: TextStyle(color: Colors.green),
                              ),
                              subtitle: Text(
                                widget.flashCards[_currentFlashCardIndex].word,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                )),
            Theme(
                data: ThemeData(primaryColor: _textFieldBorderColor),
                child: TextFormField(
                    controller: _myEditingController,
                    onEditingComplete: () async {
                      _numberOfAttempts++;

                      final value = _myEditingController.value.text;
                      bool correct = value.toLowerCase().trim() ==
                          widget.flashCards[_currentFlashCardIndex].word
                              .toLowerCase();
                      if (correct &&
                          _currentFlashCardIndex ==
                              widget.flashCards.length - 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new WritingActivityResult(
                                      numberOfAttempts: _numberOfAttempts,
                                      numberOfIncorrectAttempts:
                                          _numberOfIncorrectAttempts,
                                      flashCards: widget.flashCards,
                                    )));
                      } else
                        setState(() {
                          _currentFlashCardIndex += (correct) ? 1 : 0;
                          _numberOfIncorrectAttempts[_currentFlashCardIndex] +=
                              (correct) ? 0 : 1;
                          _textFieldBorderColor =
                              (correct) ? Colors.yellow : Colors.red;
                          _helperTextColor =
                              (correct) ? Colors.black54 : Colors.red;
                          _textFieldHelperText = (correct)
                              ? ENTER_ANSWER_TITLE
                              : ENTER_CORRECT_ANSWERS_TITLE;
                          _answer = (correct) ? null : value;
                          _myEditingController.clear();
                        });
                    },
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        if (value ==
                            widget.flashCards[_currentFlashCardIndex].word)
                          setState(() {
                            _suffixIconVisible = true;
                            _textFieldBorderColor = Colors.green;
                            _helperTextColor = Colors.green;
                            _textFieldHelperText = CORRECT_ANSWER;
                            _correctAnswer = true;
                          });
                      } else {
                        setState(() {
                          _suffixIconVisible = true;
                          _correctAnswer = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        helperStyle:
                            TextStyle(fontSize: 15, color: _helperTextColor),
                        helperText: _textFieldHelperText,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: _textFieldBorderColor, width: 3),
                        ),
                        suffixIcon: (_suffixIconVisible)
                            ? GestureDetector(
                                child: (_correctAnswer)
                                    ? Icon(Icons.done, color: Colors.green)
                                    : Text("Không biết",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                onTap: (_correctAnswer)
                                    ? null
                                    : () {
                                        setState(() {
                                          _answer = '';
                                        });
                                      })
                            : null)))
          ],
        ));
  }

  double keyboardIsVisible() {
    final visible = !(MediaQuery.of(context).viewInsets.bottom == 0);
    return (visible)
        ? ((MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom) *
            40 /
            100)
        : (MediaQuery.of(context).size.height * 60 / 100);
  }
}
