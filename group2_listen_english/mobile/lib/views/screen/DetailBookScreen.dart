import 'package:flutter/material.dart';
import 'package:mobile/views/screen/ChatScreen.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("List lesson"),
      ),
      body: new ListView.builder(itemCount: listLesson.length, itemBuilder: (context, index) {
        return _buildRow(listLesson[index], index, context);
      }),
    );
  }

  Widget _buildRow(String title, int index, BuildContext context) {
    final color = index < 5 ? Colors.red : Colors.blue;
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(
                  Icons.book,
                  color: color,
                  size: 26,
                ),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              new Spacer(),
              // Container(
              //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //   child: Icon(Icons.check_box_outline_blank, color: Colors.green)
              // ),
              Icon(Icons.navigate_next, color: Colors.black),
            ],
          ),
        ));
  }
}
