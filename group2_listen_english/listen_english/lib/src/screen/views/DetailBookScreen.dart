import 'package:flutter/material.dart';

class DetailBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listLesson = [
      "Lesson 1 - Started",
      "Lesson 2 - Started",
      "Lesson 3 - Started",
      "Lesson 4 - Started",
      "Lesson 5 - Started",
      "Lesson 6 - Started",
      "Lesson 7 - Started",
      "Lesson 8 - Started",
    ];
    final fiveLesson = [
      "Lesson 1 - Started",
      "Lesson 2 - Started",
      "Lesson 3 - Started",
      "Lesson 4 - Started",
      "Lesson 5 - Started",
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("List lesson"),
      ),
      body: new ListView.builder(itemBuilder: (context, index) {
        if (index >= listLesson.length) {
          listLesson.addAll(fiveLesson);
        }
        return _buildRow(listLesson[index], index);
      }),
    );
  }

  Widget _buildRow(String title, int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Icon(Icons.favorite, color: Colors.red,),
          ),
          Text(title, style: TextStyle(color: Colors.black, fontSize: 18),)
        ],
      ),
    );
  }
}
