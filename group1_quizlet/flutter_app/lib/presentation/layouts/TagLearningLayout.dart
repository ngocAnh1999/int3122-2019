import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';

typedef void ColorCallback();

class TagLearningLayout extends StatefulWidget {
  final FlashCard flashCard;
  final Text title;
  final ColorCallback onClicked;
  TagLearningLayout({Key key, this.flashCard, this.title, this.onClicked})
      : super(key: key);

  @override
  TagLearningState createState() => new TagLearningState();
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
//          clickEvent();
          widget.onClicked();
        },
      ),
    );
  }
}
