import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/lesson.dart';
import 'package:quizlet_clone/core/models/flashCard.dart';
import 'package:quizlet_clone/core/repositories/implementations/flashCardRepositoryImpl.dart';
import 'package:quizlet_clone/core/services/flashCardService.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardLayout.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardLearningLayout.dart';
import 'package:quizlet_clone/presentation/views/MatchTagLearningController.dart';
import 'package:quizlet_clone/presentation/views/TagLearningController.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'FlashCardItem.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;
  final Future<List<FlashCard>> flashCards;

  static final FlashCardService fcService =
      new FlashCardService(repository: new FlashCardRepositoryImpl());

  LessonView({Key key, this.lesson})
      : flashCards = fcService.getFlashCards(lessonId: lesson.id),
        super(key: key);

  @override
  LessonViewState createState() => new LessonViewState();
}

class LessonViewState extends State<LessonView> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: FutureBuilder(
        future: widget.flashCards,
        builder: (context, snapshot) {
          final flashCards = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("No connection"),
              );
            case ConnectionState.waiting:
              return Center(
                child: Text("Waiting for connection"),
              );
            case ConnectionState.active:
              return Center(
                child: Text("Getting lesson"),
              );
            case ConnectionState.done:
              return ListView(
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(
                          "${flashCards.length} thuật ngữ  |  ",
                          style: TextStyle(fontSize: 18),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage("images/profile.jpg"),
                        ),
                        Text(
                          " minmon98",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlashCardLearningLayout(
                              iconData: Icons.refresh,
                              title: "Học",
                              flashCardLearningEvent: null,
                            ),
                            FlashCardLearningLayout(
                              iconData: Icons.folder_open,
                              title: "Thẻ ghi nhớ",
                              flashCardLearningEvent: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TagLearningController(
                                              lesson: widget.lesson,
                                              flashCards: flashCards,
                                            )));
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlashCardLearningLayout(
                              iconData: Icons.border_color,
                              title: "Viết",
                              flashCardLearningEvent: null,
                            ),
                            FlashCardLearningLayout(
                              iconData: Icons.filter_none,
                              title: "Ghép thẻ",
                              flashCardLearningEvent: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MatchTagLearningController(
                                              lesson: widget.lesson,
                                              flashCards: flashCards,
                                            )));
                              },
                            ),
                            FlashCardLearningLayout(
                              iconData: Icons.insert_drive_file,
                              title: "Kiểm tra",
                              flashCardLearningEvent: null,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                      title: Column(
                    children:
                        List<Widget>.from(flashCards.map((FlashCard flashCard) {
                      return FlashCardItem(
                        flashCard: flashCard,
                      );
                    }).toList()),
                  ))
                ],
              );
          }
          return null;
        },
      ),
    );
  }
}
