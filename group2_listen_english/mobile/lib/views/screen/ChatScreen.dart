import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Widget viewBottom = new Container(
    //   alignment: Alignment.bottomCenter,
    //   child: Text("Play/Pause"),
    // );

    // Widget sectionBottom(String title) {
    //   return Positioned(
    //       child: new Align(
    //     alignment: FractionalOffset.bottomCenter,
    //     child: Text("Bottom"),
    //   ));
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Screen"),
        ),
        body: ListView(
          children: <Widget>[
            message("Hello Bob!", MainAxisAlignment.start),
            message("Hello Harry!", MainAxisAlignment.end),
            message("How are you today?", MainAxisAlignment.start),
            message("Good! It is so beautiful!", MainAxisAlignment.end),
            message("Yeah, have a nice day!", MainAxisAlignment.start),
            message("You too!", MainAxisAlignment.end),
            message("Yeah, have a nice day!", MainAxisAlignment.start),
            message("You too!", MainAxisAlignment.end),
            message("Yeah, have a nice day!", MainAxisAlignment.start),
            message("You too!", MainAxisAlignment.end),
            message("Yeah, have a nice day!", MainAxisAlignment.start),
            message("You too!", MainAxisAlignment.end),
            message("Yeah, have a nice day!", MainAxisAlignment.start),
            message("You too!", MainAxisAlignment.end),
            // sectionBottom("Abc"),
          ],
        ));
  }

  Widget message(String text, MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(text);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            padding: EdgeInsets.all(10.0),
            child: Text(text),
            // decoration: myBoxDecoration(),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        )
      ],
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      // color: Colors.red,
      width: 5.0,
    ),
  );
}
