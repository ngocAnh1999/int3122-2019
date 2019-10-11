import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

enum TtsState { playing, stopped }

class _ChatScreenState extends State<ChatScreen> {
  // final flutterTts = FlutterTts();

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  int silencems;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();
  }

  // Future _speak(String text) async {
  //   if (text != null) {
  //     if (text.isNotEmpty) {
  //       var result = await flutterTts.speak(text);
  //       if (result == 1) setState(() => ttsState = TtsState.playing);
  //     }
  //   }
  // }

  Future _read(String text) async {
    /// Wenn noch am Reden, dann Klappe halten!
    await flutterTts.stop();
    if (text != null && text.isNotEmpty) {
      /// Als Kleinbuchstaben aussprechen lassen, da sonst beispielsweise "Großbuchstabe X" statt nur "X" gesagt wird...
      await flutterTts.speak(text.toLowerCase());
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

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
            _read(text);
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
