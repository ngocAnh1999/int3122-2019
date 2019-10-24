import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';

class FlashCardItem extends StatelessWidget {
  final FlashCard flashCard;

  FlashCardItem({@required this.flashCard}) : super(key: ObjectKey(flashCard));

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
