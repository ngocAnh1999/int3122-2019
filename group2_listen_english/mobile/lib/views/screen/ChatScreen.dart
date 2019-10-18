import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile/core/models/Message.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

enum TtsState { playing, stopped }

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> listMessages = [
    Message(
        id: "0", text: "Hello Bob!", type: TYPE.ONE_HUMAN, voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Hello Harry!",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Harry!"),
    Message(
        id: "0",
        text: "How are you today?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Good! It is so beautiful!",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Yeah, have a nice day!",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0", text: "You too!", type: TYPE.TWO_HUMAN, voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Yeah, have a nice day!",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0", text: "You too!", type: TYPE.TWO_HUMAN, voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Yeah, have a nice day!",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0", text: "You too!", type: TYPE.TWO_HUMAN, voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Yeah, have a nice day!",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0", text: "You too!", type: TYPE.TWO_HUMAN, voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Yeah, have a nice day!",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0", text: "You too!", type: TYPE.TWO_HUMAN, voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Yeah, have a nice day!",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0", text: "You too!", type: TYPE.TWO_HUMAN, voice: "Hello Bob!"),
  ];

//   Timer timer = new Timer(new Duration(seconds: 5), () {
//    debugPrint("Print after 5 seconds");
// });
  // final flutterTts = FlutterTts();

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  int silencems;
  bool speakingState = false;
  final GlobalKey _menuKey = new GlobalKey();
  String _newVoiceText;
  int indexSpeaking = 0;
  String _now;
  Timer _everySecond;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        if (speakingState) {
          // _now = DateTime.now().second.toString();
          indexSpeaking++;
        }
      });
      if (indexSpeaking >= listMessages.length - 1) {
        _everySecond.cancel();
      }
    });
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

  void _changeScreen() {
    setState(() {
      // sets it to the opposite of the current screen
      speakingState = !speakingState;
    });
  }

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
      appBar: AppBar(title: Text("Chat Screen"), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
        PopupMenuButton(
            key: _menuKey,
            itemBuilder: (_) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                      child: const Text('Luyện nghe'), value: 'listen'),
                  new PopupMenuItem<String>(
                      child: const Text('Luyện với Bot'), value: 'vsBot'),
                  new PopupMenuItem<String>(
                      child: const Text('Luyện nói 2 người'), value: 'twoBot'),
                  // new PopupMenuItem<String>(
                  //   child: Row(
                  //     children: <Widget>[],
                  //   ),
                  // ),
                ],
            onSelected: (_) {})
      ]),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 50.0),
            itemCount: listMessages.length,
            itemBuilder: (context, index) {
              return _buildRow(
                listMessages[index],
                index,
                context,
              );
            }),
      ),
      bottomSheet: bottomChat(),
    );
  }

  Widget _buildRow(Message message, int index, BuildContext context) {
    final backgroundMessageColor =
        indexSpeaking == index ? Colors.red[100] : Colors.blue[100];
    final borderMessageColor =
        indexSpeaking == index ? Colors.red : Colors.transparent;
    final textMessage = message.text;
    final alignment = message.type == TYPE.ONE_HUMAN
        ? MainAxisAlignment.start
        : MainAxisAlignment.end;
    indexSpeaking == index ? _read(textMessage) : null;
    return GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: alignment,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print(textMessage);
                _read(textMessage);
              },
              child: Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(textMessage),
                // decoration: myBoxDecoration(),
                decoration: BoxDecoration(
                  color: backgroundMessageColor,
                  border: Border.all(color: borderMessageColor),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: alignment == MainAxisAlignment.end
                          ? Radius.circular(10.0)
                          : Radius.circular(0.0),
                      bottomRight: alignment == MainAxisAlignment.start
                          ? Radius.circular(10.0)
                          : Radius.circular(0.0)),
                ),
              ),
            )
          ],
        ));
  }

  Widget message(String text, MainAxisAlignment alignment, int indexSpeaking) {
    final Color tintColor =
        (indexSpeaking == 0) ? Colors.red : Colors.blue[100];
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
              color: tintColor,
              // border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: alignment == MainAxisAlignment.end
                      ? Radius.circular(10.0)
                      : Radius.circular(0.0),
                  bottomRight: alignment == MainAxisAlignment.start
                      ? Radius.circular(10.0)
                      : Radius.circular(0.0)),
            ),
          ),
        )
      ],
    );
  }

  Widget bottomChat() {
    return Container(
      height: 50,
      color: Colors.blueGrey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: _changeScreen,
            child: Icon(
              speakingState ? Icons.mic : Icons.pause_circle_filled,
              color: Colors.blue,
              size: 32.0,
            ),
          )
        ],
      ),
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
