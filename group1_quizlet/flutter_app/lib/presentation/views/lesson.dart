import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';
import 'package:flutter_app/presentation/layouts/simple_layout.dart';
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

class Slider extends StatelessWidget {
  final Lesson lesson;

  Slider({this.lesson});

  @override
  Widget build(BuildContext context) => new Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index >= lesson.vocabs.length) {
            return null;
          }
          return new SimpleExample(
            flashCard: lesson.vocabs[index],
          );
        },
        itemCount: lesson.vocabs.length,
        viewportFraction: 0.8,
        scale: 0.9,
      );
}

class LessonViewState extends State<LessonView> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.lesson.title),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
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
                    return new SimpleExample(
                      flashCard: widget.lesson.vocabs[index],
                    );
                  },
                  itemCount: widget.lesson.vocabs.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
            ),
            ListTile(
              title: Column(
                children: widget.lesson.vocabs.map((FlashCard flashCard) {
                  return FlashCardItem(
                    flashCard: flashCard,
                  );
                }).toList(),
              )
            )
          ],
        ));
  }
}
