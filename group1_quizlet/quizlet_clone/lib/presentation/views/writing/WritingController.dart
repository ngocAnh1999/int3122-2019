import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/presentation/views/writing/WritingFinishLayout.dart';

final String SUGGUEST_ANSWER_TITLE = "Đáp án đúng";
final String YOUR_ANSWER_TITLE = "Đáp án của bạn";
final String ENTER_ENGLISH_TITLE = "Nhập tiếng anh vào đây";
final String ENTER_TRUE_ANSWERS_TITLE = "Chép lại đáp án đúng";
final String TRUE_ANSWER = "Đáp án đúng";

class WritingController extends StatefulWidget {
  final Lesson lesson;
  final List<FlashCard> flashCards;

  WritingController({Key key, this.lesson, this.flashCards}) : super(key: key);

  @override
  WritingControllerState createState() => new WritingControllerState();
}

class WritingControllerState extends State<WritingController> {
  final myEditingController = TextEditingController();
  int index = 0;
  var suffixIcon = null;
  var containerChild = null;
  String helperText = ENTER_ENGLISH_TITLE;
  Color textFieldBorderColor = Colors.yellow;
  Color helperTextColor = Colors.black54;
  var wrongTimes = null;
  var answerTimes = 0;

  @override
  void initState() {
    super.initState();
    wrongTimes = List.filled(widget.flashCards.length, 0);

    suffixIcon = GestureDetector(
      child: Text("Không biết",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      onTap: () {
        showContainerChild("");
      },
    );
  }

  void increaseAnswerTime() {
    setState(() {
      answerTimes++;
    });
  }

  void showContainerChild(String answer) {
    setState(() {
      hideSuffixIcon();
      if (wrongTimes[index] == 0) {
        wrongTimes[index]++;
        answerTimes++;
      }
      helperText = ENTER_TRUE_ANSWERS_TITLE;
      helperTextColor = Colors.red;
      textFieldBorderColor = Colors.red;
      containerChild = (answer == "")
          ? Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    SUGGUEST_ANSWER_TITLE,
                    style: TextStyle(color: Colors.green),
                  ),
                  subtitle: Text(
                    widget.flashCards[index].word,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                )
              ],
            )
          : Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    YOUR_ANSWER_TITLE,
                    style: TextStyle(color: Colors.red),
                  ),
                  subtitle: Text(
                    answer,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
                ListTile(
                  title: Text(
                    SUGGUEST_ANSWER_TITLE,
                    style: TextStyle(color: Colors.green),
                  ),
                  subtitle: Text(
                    widget.flashCards[index].word,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                )
              ],
            );
    });
  }

  void hideContainerChild() {
    setState(() {
      containerChild = null;
    });
  }

  void hideSuffixIcon() {
    setState(() {
      suffixIcon = null;
    });
  }

  void showSuffixIcon() {
    setState(() {
      suffixIcon = GestureDetector(
        child: Text("Không biết",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        onTap: () {
          showContainerChild("");
        },
      );
    });
  }

  void trueAnswer() {
    setState(() {
      textFieldBorderColor = Colors.green;
      helperTextColor = Colors.green;
      helperText = TRUE_ANSWER;
      suffixIcon = GestureDetector(
        onTap: null,
        child: Icon(
          Icons.done,
          color: Colors.green,
        ),
      );
    });
  }

  void increaseIndex() {
    setState(() {
      if (index < widget.flashCards.length) index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 70 / 100,
            lineHeight: 20.0,
            center: Text(
                "${((index / widget.flashCards.length) * 100).toStringAsFixed(0)}%"),
            percent: index / widget.flashCards.length,
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
                widget.flashCards[index].meaning,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: keyboardIsVisible(),
                child: Center(
                  child: containerChild,
                )),
            Theme(
              data: ThemeData(primaryColor: textFieldBorderColor),
              child: TextFormField(
                  controller: myEditingController,
                  onEditingComplete: () async {
                    increaseAnswerTime();
                    final value = myEditingController.value.text;
                    if (value.toLowerCase() ==
                        widget.flashCards[index].word.toLowerCase()) {
                      setState(() {
                        textFieldBorderColor = Colors.yellow;
                        helperTextColor = Colors.black54;
                        helperText = ENTER_ENGLISH_TITLE;
                      });
                      hideContainerChild();
                      if (index < widget.flashCards.length - 1) {
                        increaseIndex();
                      } else {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new WritingFinsishLayout(
                                      answerTimes: answerTimes,
                                      wrongTimes: wrongTimes,
                                      flashCards: widget.flashCards,
                                    )));
                        setState(() {
                          wrongTimes = List.filled(widget.flashCards.length, 0);
                          helperText = ENTER_ENGLISH_TITLE;
                          answerTimes = 0;
                          index = 0;
                          showSuffixIcon();
                        });
                      }
                      myEditingController.clear();
                    } else {
                      setState(() {
                        wrongTimes[index]++;
                      });
                      showContainerChild(myEditingController.value.text);
                      myEditingController.clear();
                    }
                  },
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      hideSuffixIcon();
                    } else if (containerChild == null) {
                      showSuffixIcon();
                    }
                    if (value == widget.flashCards[index].word) {
                      trueAnswer();
                    } else {
                      if (containerChild == null) {
                        setState(() {
                          textFieldBorderColor = Colors.yellow;
                          helperTextColor = Colors.black54;
                          helperText = ENTER_ENGLISH_TITLE;
                        });
                      } else {
                        setState(() {
                          textFieldBorderColor = Colors.red;
                          helperTextColor = Colors.red;
                          helperText = ENTER_TRUE_ANSWERS_TITLE;
                        });
                      }
                    }
                  },
                  decoration: InputDecoration(
                      helperStyle:
                          TextStyle(fontSize: 15, color: helperTextColor),
                      helperText: helperText,
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: textFieldBorderColor, width: 3),
                      ),
                      suffixIcon: suffixIcon)),
            )
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
