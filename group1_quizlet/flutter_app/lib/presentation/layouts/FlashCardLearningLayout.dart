import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void FlashCardLearningEvent();

class FlashCardLearningLayout extends StatelessWidget {
  final IconData iconData;
  final String title;
  final FlashCardLearningEvent flashCardLearningEvent;

  FlashCardLearningLayout({this.iconData, this.title, this.flashCardLearningEvent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          child: GestureDetector(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 3, color: Colors.lightBlueAccent),
                      top: BorderSide(color: Colors.white),
                      left: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    iconData,
                    color: Colors.deepPurple,
                    size: 36.0,
                  ),
                  Text(title.toUpperCase(),
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            onTap: flashCardLearningEvent
          )
      ),
    );
  }
}
