import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardLayout.dart';
import 'package:quizlet_clone/presentation/views/exam/ExamView.dart';
import 'package:quizlet_clone/presentation/views/lesson/MatchingCardView.dart';
import 'package:quizlet_clone/presentation/views/matching/CardMemorizingActivity.dart';
import 'package:quizlet_clone/presentation/views/writing/WritingActivity.dart';

import 'FlashCardItem.dart';
import 'LearningActivity.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;
  final FlashCardService fcService = FlashCardService.instance;

  LessonView({Key key, this.lesson}) : super(key: key);

  @override
  LessonViewState createState() => new LessonViewState();
}

class LessonViewState extends State<LessonView> {
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FlashCardService.instance.getFlashCards(lessonId: widget.lesson.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.lesson.title),
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.done:
              List<FlashCard> flashCards = snapshot.data;
              return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.lesson.title),
                  ),
                  body: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      ListTile(
                        title: SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= flashCards.length) {
                                return null;
                              }
                              return new FlashCardLayout(
                                flashCard: flashCards[index],
                                ratio: 1.25,
                              );
                            },
                            itemCount: flashCards.length,
                            viewportFraction: 0.8,
                            scale: 0.9,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          widget.lesson.title,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Text(
                              "${flashCards.length} thuật ngữ  |  ",
                              style: TextStyle(fontSize: 18),
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  FacebookProfileGetter.getAvatarUrl(
                                      facebookId: widget.lesson.facebookId)),
                            ),
                            Text(
                              '\t' + widget.lesson.username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      ListTile(
                          title: Column(
                              children: List<Widget>.from(
                                  flashCards.map((FlashCard flashCard) {
                                    return FlashCardItem(
                                      flashCard: flashCard,
                                    );
                                  }).toList()))),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 55),
                      )
                    ],
                  ),
                  bottomSheet: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                              BorderSide(width: 1, color: Colors.black12))),
                      child: Row(children: <Widget>[
                        LearningActivity(
                            iconData: Icons.folder_open,
                            title: "Thẻ ghi nhớ",
                            learningActivityEvent: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CardMemorizingActivity(
                                              lesson: widget.lesson)));
                            }),
                        LearningActivity(
                            iconData: Icons.border_color,
                            title: "Viết",
                            learningActivityEvent: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WritingActivity(
                                        lesson: widget.lesson,
                                        flashCards: flashCards,
                                      )));
                            }),
                        LearningActivity(
                            iconData: Icons.filter_none,
                            title: "Ghép thẻ",
                            learningActivityEvent: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchingCardView(
                                          lesson: widget.lesson)));
                            }),
                        LearningActivity(
                            iconData: Icons.insert_drive_file,
                            title: "Kiểm tra",
                            learningActivityEvent: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExamView(
                                        lesson: widget.lesson,
                                        flashCards: flashCards,
                                      )));
                            })
                      ])));
          }
          return null;
        });
  }
}
