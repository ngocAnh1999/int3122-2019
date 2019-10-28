import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/presentation/views/matching/SwipeableFlashCard.dart';
import 'package:quizlet_clone/presentation/views/matching/CardMemorizingActivityResult.dart';

const String APPBAR_TITLE = "Thẻ ghi nhớ";

class CardMemorizingActivity extends StatefulWidget {
  final Lesson lesson;

  CardMemorizingActivity({Key key, @required this.lesson}) : super(key: key);

  @override
  CardMemorizingActivityState createState() =>
      new CardMemorizingActivityState();
}

class CardMemorizingActivityState extends State<CardMemorizingActivity> {
  int count = 0;
  List<FlashCard> needReviewFlashCards = new List<FlashCard>();

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
          APPBAR_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ),
      body: Center(
          child: FutureBuilder(
              future: FlashCardService.instance
                  .getFlashCards(lessonId: widget.lesson.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    List<FlashCard> flashCards = snapshot.data;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Stack(
                        alignment: Alignment.center,
                        children: flashCards.map((FlashCard flashCard) {
                          return SwipeableFlashCard(
                            ratio: 0.8,
                            swipedEventCallback: (learnt) async {
                              if (!learnt) {
                                needReviewFlashCards.add(flashCards[count]);
                              }
                              count++;
                              if (count == flashCards.length) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new CardMemorizingActivityResult(
                                                lesson: widget.lesson,
                                                needReviewFlashCards:
                                                    needReviewFlashCards)));
                              }
                            },
                            flashCard: flashCard,
                          );
                        }).toList(),
                      ),
                    );
                }
                return null;
              })),
    );
  }
}
