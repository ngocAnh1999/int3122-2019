import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';

typedef void ColorCallback();

class TagLearningLayout extends StatefulWidget {
  final FlashCard flashCard;
  final Text title;
  ColorCallback onClicked;
  final tagLearningState = new TagLearningState();

  TagLearningLayout(
      {Key key, this.flashCard, this.title, this.onClicked})
      : super(key: key);

  void clearEvent() {
    tagLearningState.clearEvent();
  }

  void clickEvent() {
    tagLearningState.clickEvent();
  }

  void successEvent() {
    tagLearningState.successEvent();
  }

  void failEvent() {
    tagLearningState.failEvent();
  }



  @override
  TagLearningState createState() => tagLearningState;
}

class TagLearningState extends State<TagLearningLayout> {
  Color background = Colors.white;

  void clearEvent() {
    setState(() {
      background = Colors.white;
    });
  }

  void clickEvent() {
    setState(() {
      background = Colors.yellowAccent;
    });
  }

  void successEvent() {
    setState(() {
      background = Colors.lightGreenAccent;
    });
  }

  void failEvent() {
    setState(() {
      background = Colors.redAccent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: background,
                border: Border.all(color: Colors.black38, width: 3)),
            child: Center(
              child: widget.title,
            )),
        onTap: () {
          widget.onClicked();
        },
      ),
    );
  }
}
