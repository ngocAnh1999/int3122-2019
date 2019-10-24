import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/User.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/core/utilities/FacebookAvatarGetter.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardLayout.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardLearningLayout.dart';
import 'package:quizlet_clone/presentation/views/MatchTagLearningController.dart';
import 'package:quizlet_clone/presentation/views/TagLearningController.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quizlet_clone/presentation/views/WritingController.dart';
import 'FlashCardItem.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;
  final User user;
  final FlashCardService fcService = FlashCardService.instance;

  LessonView({Key key, this.lesson, this.user}) : super(key: key);

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
        future: widget.fcService.getFlashCards(lessonId: widget.lesson.id),
        builder: (context, snapshot) {
          final flashCards = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
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
                          backgroundImage: NetworkImage(
                              FacebookProfileGetter.getAvatarUrl(
                                  facebookId: widget.user.facebookId)),
                        ),
                        Text(
                          '\t' + widget.user.username,
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
                              flashCardLearningEvent: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WritingController(
                                              lesson: widget.lesson,
                                              flashCards: flashCards,
                                            )));
                              },
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
