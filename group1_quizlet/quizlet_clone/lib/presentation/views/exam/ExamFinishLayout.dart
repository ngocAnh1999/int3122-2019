import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizlet_clone/presentation/views/exam/AnswerLayout.dart';

final EXCELLENT_TITLE = "Tốt lắm";
final GOOD_TITLE = "Khá tốt rồi";
final NORMAL_TITLE = "Tàm tạm";
final POOR_TITLE = "Kém quá";

class ExamFinishLayout extends StatefulWidget {
  final int trueAnswers;
  final int count;
  final List<AnswerLayout> answerLayouts;
  ExamFinishLayout({Key key, this.trueAnswers, this.count, this.answerLayouts})
      : super(key: key);

  double getPercentPoint() {
    return double.parse((trueAnswers / count).toStringAsFixed(2));
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

  @override
  ExamFinishLayoutState createState() => new ExamFinishLayoutState();
}

class ExamFinishLayoutState extends State<ExamFinishLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Kết quả kiểm tra",
          style: TextStyle(color: Colors.black54),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black54,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )),
            ListTile(
              title: Center(
                child: Text(
                  "Bạn đã trả lời sai ${widget.count - widget.trueAnswers} trong tổng số ${widget.count} câu hỏi",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.answerLayouts
                    .map((answerLayout) => answerLayout)
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
