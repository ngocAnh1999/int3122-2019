import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/Vocabulary.dart';

class VocabularyItem extends StatelessWidget {
  final Vocabulary vocabulary;

  VocabularyItem({Vocabulary vocabulary})
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: widget.lesson.vocabs.map((Vocabulary vocabulary) {
          return VocabularyItem(
            vocabulary: vocabulary,
          );
        }).toList(),
      ),
    );
  }
}
