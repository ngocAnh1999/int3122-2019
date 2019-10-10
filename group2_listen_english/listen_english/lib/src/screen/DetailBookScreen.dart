import 'package:flutter/material.dart';

class DetailBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listLesson = [
      "Lesson 1 - Started",
      "Lesson 2 - Alphabet",
      "Lesson 3 - Work",
      "Lesson 4 - Animals",
      "Lesson 5 - Countries",
      "Lesson 6 - Shopping",
      "Lesson 7 - Games",
      "Lesson 8 - Sports",
    ];
    final fiveLesson = [
      "Lesson 1 - Sports",
      "Lesson 2 - Alphabet",
      "Lesson 3 - Work",
      "Lesson 4 - Animals",
      "Lesson 5 - Countries",
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
    final color = index < 5 ? Colors.red : Colors.blue;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Icon(Icons.favorite, color: color,),
          ),
          Text(title, style: TextStyle(color: Colors.black, fontSize: 18),)
        ],
      ),
    );
  }
}
