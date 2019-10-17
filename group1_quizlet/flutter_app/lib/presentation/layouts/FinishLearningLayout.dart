import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double ICON_SIZE = 70;
final String TITLE = "Làm tốt lắm !";
final String DESCRIPTION = "Bạn đã học hết các nội dung";
final String BUTTON_TITLE = "chơi lại";

class FinishLearningLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "🏅",
              style: TextStyle(fontSize: ICON_SIZE),
            ),
            Text(
              TITLE,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              DESCRIPTION,
              style: TextStyle(fontSize: 18),
            ),
            RaisedButton(
              color: Colors.greenAccent,
              child: Text("Chơi lại"),
              onPressed: () {
                Navigator.pop(context);
              },
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
            )
          ],
        ),
      ),
    );
  }
}
