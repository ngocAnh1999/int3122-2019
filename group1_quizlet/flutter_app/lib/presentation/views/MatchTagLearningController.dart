import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/presentation/layouts/FinishLearningLayout.dart';
import 'package:flutter_app/presentation/layouts/TagLearningLayout.dart';

final int LIST_TAG_LENGTH = 6;
final int MAP_LENGTH = 12;
final int MAP_ROW = 4;
final int MAP_COLUMN = 3;

class MatchTagLearningController extends StatefulWidget {
  final Lesson lesson;

  MatchTagLearningController({Key key, this.lesson}) : super(key: key);

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
  var visitedTag = [];

  @override
  void initState() {
    super.initState();
    generateListTagLearning();
    generatePosition();
    generateChildren();
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
    setState(() {
      listTagLearning.clear();
      var visited = [];
      int minLength = (LIST_TAG_LENGTH > widget.lesson.vocabs.length)
          ? widget.lesson.vocabs.length
          : LIST_TAG_LENGTH;
      for (int index = 0; index < minLength; index++) {
        var random = new Random();
        int key = random.nextInt(widget.lesson.vocabs.length);
        while (visited.contains(key)) {
          key = random.nextInt(widget.lesson.vocabs.length);
        }
        visited.add(key);
        listTagLearning.add(TagLearningLayout(
          title: Text(
            "${widget.lesson.vocabs[key].word}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          flashCard: widget.lesson.vocabs[key],
          onClicked: () {
            switch (count) {
              case 0:
                setFirstIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.lesson.vocabs[key].word}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(first)) {
                  increaseCount();
                  visitedAppend(first);
                }
                break;
              case 1:
                setSecondIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.lesson.vocabs[key].word}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(second)) {
                  increaseCount();
                  visitedAppend(second);
                }
                if (count == 2) {
                  var firstTag = listTagLearning[first];
                  var secondTag = listTagLearning[second];
                  if (firstTag.flashCard.word == secondTag.flashCard.word) {
                    listTagLearning.removeWhere((item) => item == firstTag);
                    listTagLearning.removeWhere((item) => item == secondTag);
                    if (listTagLearning.isEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinishLearningLayout()));
                    }
                    generatePosition();
                    generateChildren();
                    print("Success");
                  } else {
                    print("Fail");
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
            "${widget.lesson.vocabs[key].meaning}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          flashCard: widget.lesson.vocabs[key],
          onClicked: () {
            switch (count) {
              case 0:
                setFirstIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.lesson.vocabs[key].meaning}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(first)) {
                  increaseCount();
                  visitedAppend(first);
                }
                break;
              case 1:
                setSecondIndex(listTagLearning.indexWhere((item) {
                  var itemTitle = item.title.toString();
                  var tagTitle = Text(
                    "${widget.lesson.vocabs[key].meaning}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ).toString();
                  return itemTitle == tagTitle;
                }));
                if (!visitedTag.contains(second)) {
                  increaseCount();
                  visitedAppend(second);
                }
                if (count == 2) {
                  var firstTag = listTagLearning[first];
                  var secondTag = listTagLearning[second];
                  if (firstTag.flashCard.word == secondTag.flashCard.word) {
                    listTagLearning.removeWhere((item) => item == firstTag);
                    listTagLearning.removeWhere((item) => item == secondTag);
                    if (listTagLearning.isEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinishLearningLayout()));
                    }
                    generatePosition();
                    generateChildren();
                    print("Success");
                  } else {
                    print("Fail");
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
          "0:42",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: Column(
        children: columnChildren,
      ),
    );
  }
}
