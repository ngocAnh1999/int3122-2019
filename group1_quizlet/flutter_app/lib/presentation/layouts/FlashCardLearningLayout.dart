import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashCardLearningLayout extends StatelessWidget {
  final IconData iconData;
  final String title;

  FlashCardLearningLayout({this.iconData, this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3,
                  color: Colors.lightBlueAccent
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.deepPurple,
                  size: 36.0,
                ),
                Text(
                    title.toUpperCase(),
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 12, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          )
      ),
    );
  }
}
