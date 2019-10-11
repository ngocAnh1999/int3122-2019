import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/FlashCard.dart';
import 'package:flutter_app/presentation/layouts/simple_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class VocabularyItem extends StatelessWidget {
  final FlashCard vocabulary;

  VocabularyItem({FlashCard vocabulary})
      : vocabulary = vocabulary,
        super(key: ObjectKey(vocabulary));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(vocabulary.word, style: TextStyle(fontSize: 20),),
            trailing: IconButton(
              icon: Icon(Icons.star_border),
              onPressed: null,
            ),
          ),
          ListTile(
            title: Text(vocabulary.meaning, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
//      body: ListView(
//        padding: const EdgeInsets.all(16.0),
//        children: widget.lesson.vocabs.map((Vocabulary vocabulary) {
//          return VocabularyItem(
//            vocabulary: vocabulary,
//          );
//        }).toList(),
//      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index >= widget.lesson.vocabs.length) {
            return null;
          }
          return new SimpleExample(vocabulary: widget.lesson.vocabs[index],);
        },
        itemCount: widget.lesson.vocabs.length,
        viewportFraction: 0.8,
        scale: 0.9,

      ),
    );
  }
}
