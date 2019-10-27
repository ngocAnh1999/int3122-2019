import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';

final EXCELLENT_TITLE = "Tốt lắm";
final GOOD_TITLE = "Khá tốt rồi";
final NORMAL_TITLE = "Tàm tạm";
final POOR_TITLE = "Kém quá";

class ResultBox {
  int wrongTimes = 0;
  List<FlashCard> flashCards = new List<FlashCard>();
}

class WritingFinsishLayout extends StatefulWidget {
  final int answerTimes;
  final List<int> wrongTimes;
  final List<FlashCard> flashCards;

  WritingFinsishLayout(
      {Key key, this.answerTimes, this.wrongTimes, this.flashCards});

  int sumOfWrongTimes() {
    int sum = 0;
    for (int index = 0; index < wrongTimes.length; index++) {
      sum += wrongTimes[index];
    }
    return sum;
  }

  double getPercentPoint() {
    int trueTimes = answerTimes - sumOfWrongTimes();
    return double.parse((trueTimes / answerTimes).toStringAsFixed(2));
  }

  String getComment() {
    final result = getPercentPoint();
    if (result >= 0.9) {
      return EXCELLENT_TITLE;
    } else if (result >= 0.8) {
      return GOOD_TITLE;
    } else if (result >= 0.65) {
      return NORMAL_TITLE;
    } else {
      return POOR_TITLE;
    }
  }

  Color getPointColor() {
    final result = getPercentPoint();
    if (result >= 0.9) {
      return Colors.green;
    } else if (result >= 0.8) {
      return Colors.blue;
    } else if (result >= 0.65) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  List<ResultBox> spilitWrongTimes() {
    List<ResultBox> listResultBox = new List<ResultBox>();
    var visited = List.filled(wrongTimes.length, false);
    for (int index = 0; index < wrongTimes.length; index++) {
      if (!visited[index]) {
        visited[index] = true;
        var resultBox = new ResultBox();
        resultBox.wrongTimes = wrongTimes[index];
        for (int index1 = 0; index1 < wrongTimes.length; index1++) {
          if (resultBox.wrongTimes == wrongTimes[index1]) {
            visited[index1] = true;
            resultBox.flashCards.add(flashCards[index1]);
          }
        }
        listResultBox.add(resultBox);
      }
    }
    return listResultBox;
  }

  @override
  WritingFinishState createState() => new WritingFinishState();
}

class WritingFinishState extends State<WritingFinsishLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: null,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: Colors.black54,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            height: 60,
          ),
          CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 8.0,
            percent: widget.getPercentPoint(),
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${(widget.getPercentPoint() * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "chính xác",
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            ),
            progressColor: widget.getPointColor(),
          ),
          ListTile(
              title: Center(
            child: Text(
              widget.getComment(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          )),
          Column(
              children: widget.spilitWrongTimes().map((ResultBox resultBox) {
            return Column(
              children: <Widget>[
                (resultBox.wrongTimes == 0)
                    ? Text(
                        "Chưa sai lần nào",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "Sai ${resultBox.wrongTimes} lần",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                Container(
                  height: 10,
                ),
                Column(
                  children: resultBox.flashCards.map((FlashCard flashCard) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          flashCard.word,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        subtitle: Text(
                          flashCard.meaning,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Container(
                  height: 20,
                )
              ],
            );
          }).toList())
        ],
      ),
    );
  }
}
