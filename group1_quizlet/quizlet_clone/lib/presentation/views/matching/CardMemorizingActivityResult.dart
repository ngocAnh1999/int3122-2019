import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/presentation/views/matching/CardMemorizingActivity.dart';

class CardMemorizingActivityResult extends StatelessWidget {
  final List<FlashCard> needReviewFlashCards;
  final Lesson lesson;

  CardMemorizingActivityResult(
      {@required this.lesson, @required this.needReviewFlashCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(""),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            ListTile(
              title: Center(
                child: Text(
                  "😊",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            Container(
              height: 30,
            ),
            ListTile(
              title: Center(
                child: Text(
                  "Làm tốt lắm !",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            ListTile(
              title: Center(
                child: Text(
                  "Tiếp tục luyện tập để nắm vững ${needReviewFlashCards.length} từ còn lại",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Column(
              children: needReviewFlashCards.map((FlashCard flashCard) {
                return Card(
                  child: ListTile(
                    title: Text(
                      flashCard.word,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RaisedButton(
                child: Text(
                  "Chơi lại",
                  style: TextStyle(fontSize: 18),
                ),
                color: Colors.cyan,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CardMemorizingActivity(lesson: this.lesson)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
