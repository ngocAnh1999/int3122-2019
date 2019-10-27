import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/presentation/views/tag/TagLearningLayout.dart';
import 'package:toast/toast.dart';

final int LIST_TAG_LENGTH = 6;
final int MAP_LENGTH = 12;
final int MAP_ROW = 4;
final int MAP_COLUMN = 3;

enum TagState { CLEAR, CLICKED, SUCCESS, FAIL }

class MatchTagLearningController extends StatefulWidget {
  final Lesson lesson;
  final List<FlashCard> flashCards;

  MatchTagLearningController({Key key, this.lesson, this.flashCards})
      : super(key: key);

  @override
  MatchTagLearningState createState() => new MatchTagLearningState();
}

class MatchTagLearningState extends State<MatchTagLearningController> {
  List<TagLearningLayout> listTagLearning = new List<TagLearningLayout>();
  List<int> listPosition = new List<int>();
  List<Expanded> columnChildren = new List<Expanded>();
  int count = 0;
  int first = 0;
  int second = 0;
  int trueAnswers = 0;
  var visitedTag = [];

  @override
  void initState() {
    generateListTagLearning();
    generatePosition();
    generateChildren();
    super.initState();
  }

  @override
  void dispose() {
    listTagLearning.clear();
    listPosition.clear();
    columnChildren.clear();
    super.dispose();
  }

  void increaseTrueAnswers() {
    setState(() {
      trueAnswers++;
    });
  }

  void visitedAppend(int index) {
    setState(() {
      visitedTag.add(index);
    });
  }

  void visitedClear() {
    setState(() {
      visitedTag.clear();
    });
  }

  void setFirstIndex(int index) {
    setState(() {
      first = index;
    });
  }

  void setSecondIndex(int index) {
    setState(() {
      second = index;
    });
  }

  void increaseCount() {
    setState(() {
      count++;
    });
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  void generateListTagLearning() {
    //print('FCS: ${widget.flashCards}');
    setState(() {
      listTagLearning.clear();
      var visited = [];
      int minLength = (LIST_TAG_LENGTH > widget.flashCards.length)
          ? widget.flashCards.length
          : LIST_TAG_LENGTH;
      for (int index = 0; index < minLength; index++) {
        var random = new Random();
        int key = random.nextInt(widget.flashCards.length);
        while (visited.contains(key)) {
          key = random.nextInt(widget.flashCards.length);
        }
        visited.add(key);
        listTagLearning.add(TagLearningLayout(
          title: Text(
            "${widget.flashCards[key].word}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          flashCard: widget.flashCards[key],
          onClicked: () async {
            switch (count) {
              case 0:
                setFirstIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.flashCards[key].word}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(first)) {
                  increaseCount();
                  var firstTag = listTagLearning[first];
                  firstTag.clickEvent();
                  visitedAppend(first);
                }
                break;
              case 1:
                setSecondIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.flashCards[key].word}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(second)) {
                  increaseCount();
                  var secondTag = listTagLearning[second];
                  secondTag.clickEvent();
                  visitedAppend(second);
                }
                if (count == 2) {
                  var firstTag = listTagLearning[first];
                  var secondTag = listTagLearning[second];
                  if (firstTag.flashCard.word == secondTag.flashCard.word) {
                    increaseTrueAnswers();
                    firstTag.successEvent();
                    secondTag.successEvent();
                    firstTag.onClicked = () {};
                    secondTag.onClicked = () {};
                    if (trueAnswers == widget.flashCards.length) {
//                      final result = await Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => FinishLearningLayout()));
                      setState(() {
                        listTagLearning.clear();
                        listPosition.clear();
                        columnChildren.clear();
                      });
//                      generateListTagLearning();
//                      generatePosition();
//                      generateChildren();
                    }
                  } else {
                    var firstTag = listTagLearning[first];
                    var secondTag = listTagLearning[second];
                    firstTag.failEvent();
                    secondTag.failEvent();
                    Toast.show("Wrong answer", context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM,
                        backgroundColor: Colors.deepPurple,
                        border: Border.all(width: 2),
                        textColor: Colors.white);
                  }
                  resetCount();
                  visitedClear();
                }
                break;
            }
          },
        ));
        TagLearningLayout meaningLayout = new TagLearningLayout();
        listTagLearning.add(TagLearningLayout(
          title: Text(
            "${widget.flashCards[key].meaning}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          flashCard: widget.flashCards[key],
          onClicked: () async {
            switch (count) {
              case 0:
                setFirstIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.flashCards[key].meaning}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(first)) {
                  increaseCount();
                  var firstTag = listTagLearning[first];
                  firstTag.clickEvent();
                  visitedAppend(first);
                }
                break;
              case 1:
                setSecondIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.flashCards[key].meaning}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(second)) {
                  increaseCount();
                  var secondTag = listTagLearning[second];
                  secondTag.clickEvent();
                  visitedAppend(second);
                }
                if (count == 2) {
                  var firstTag = listTagLearning[first];
                  var secondTag = listTagLearning[second];
                  if (firstTag.flashCard.word == secondTag.flashCard.word) {
                    increaseTrueAnswers();
                    firstTag.successEvent();
                    secondTag.successEvent();
                    firstTag.onClicked = () {};
                    secondTag.onClicked = () {};
                    if (trueAnswers == widget.flashCards.length) {
//                      final result = await Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => FinishLearningLayout()));
                      dispose();
                      initState();
//                      generateListTagLearning();
//                      generatePosition();
//                      generateChildren();
                    }
                  } else {
                    var firstTag = listTagLearning[first];
                    var secondTag = listTagLearning[second];
                    firstTag.failEvent();
                    secondTag.failEvent();
                    Toast.show("Wrong answer", context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM,
                        backgroundColor: Colors.deepPurple,
                        border: Border.all(width: 2),
                        textColor: Colors.white);
                  }
                  resetCount();
                  visitedClear();
                }
                break;
            }
          },
        ));
      }
    });
  }

  void generatePosition() {
    setState(() {
      listPosition.clear();
      var visited = [];
      for (int index = 0; index < listTagLearning.length; index++) {
        var random = new Random();
        int position = random.nextInt(MAP_LENGTH);
        while (visited.contains(position)) {
          position = random.nextInt(MAP_LENGTH);
        }
        visited.add(position);
        listPosition.add(position);
      }
    });
  }

  void generateChildren() {
    setState(() {
      columnChildren.clear();
      for (int row = 0; row < MAP_ROW; row++) {
        List<TagLearningLayout> tagRow = List<TagLearningLayout>();
        for (int column = 0; column < MAP_COLUMN; column++) {
          if (listPosition.contains(3 * row + column)) {
            tagRow.add(listTagLearning[listPosition.indexOf(3 * row + column)]);
          }
        }
        if (tagRow.isNotEmpty) {
          var expaned = new Expanded(
              child: Row(
            children: tagRow,
          ));
          columnChildren.add(expaned);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Ghép thẻ",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: columnChildren,
      ),
    );
  }
}
