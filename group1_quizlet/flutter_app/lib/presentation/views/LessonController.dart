import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';
import 'package:flutter_app/presentation/layouts/FlashCardLayout.dart';
import 'package:flutter_app/presentation/layouts/FlashCardLearningLayout.dart';
import 'package:flutter_app/presentation/views/MatchTagLearningController.dart';
import 'package:flutter_app/presentation/views/TagLearningController.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FlashCardItem extends StatelessWidget {
  final FlashCard flashCard;

  FlashCardItem({FlashCard flashCard})
      : flashCard = flashCard,
        super(key: ObjectKey(flashCard));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              flashCard.word,
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              icon: Icon(Icons.star_border),
              onPressed: null,
            ),
          ),
          ListTile(
            title: Text(
              flashCard.meaning,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class LessonView extends StatefulWidget {
  final Lesson lesson;
  LessonView({Key key, this.lesson}) : super(key: key);
  @override
  LessonViewState createState() => new LessonViewState();
}

class LessonViewState extends State<LessonView> {
  Widget build(BuildContext context) {
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
                    if (index >= widget.lesson.vocabs.length) {
                      return null;
                    }
                    return new FlashCardLayout(
                      flashCard: widget.lesson.vocabs[index],
                      ratio: 1.25,
                    );
                  },
                  itemCount: widget.lesson.vocabs.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
            ),
            ListTile(
              title: Text(
                widget.lesson.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    "${widget.lesson.vocabs.length} thuật ngữ  |  ",
                    style: TextStyle(fontSize: 18),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("images/profile.jpg"),
                  ),
                  Text(
                    " minmon98",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                                  builder: (context) => TagLearningController(
                                      lesson: widget.lesson)));
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
                                  builder: (context) => MatchTagLearningController(
                                      lesson: widget.lesson,)));
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
              children: widget.lesson.vocabs.map((FlashCard flashCard) {
                return FlashCardItem(
                  flashCard: flashCard,
                );
              }).toList(),
            ))
          ],
        ));
  }
}
