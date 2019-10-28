import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void LearningActivityEvent();

class LearningActivity extends StatelessWidget {
  final IconData iconData;
  final String title;
  final LearningActivityEvent learningActivityEvent;

  LearningActivity({this.iconData, this.title, this.learningActivityEvent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            child: Container(
              height: 55,
//                decoration: BoxDecoration(
//                    border: Border(
//                        bottom:
//                            BorderSide(width: 3, color: Colors.lightBlueAccent),
//                        top: BorderSide(color: Colors.white),
//                        left: BorderSide(color: Colors.white),
//                        right: BorderSide(color: Colors.white))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    iconData,
                    color: Colors.deepPurple,
                    size: 24.0,
                  ),
                  Text(title,
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 12)),
                ],
              ),
            ),
            onTap: learningActivityEvent));
  }
}
