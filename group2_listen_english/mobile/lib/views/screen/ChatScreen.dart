import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile/core/models/Message.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

enum TtsState { playing, stopped }
enum LearningMode { botVsBot, playerVsPlayer, botVsPlayer }

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

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
        text: "How many people are there in your family?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text:
            "There are 5 people in my family: my father, mother, brother, sister, and me.",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Does your family live in a house or an apartment?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "We live in a house in the countryside.",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "What does your father do?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "My father is a doctor. He works at the local hospital.",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "How old is your mother?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "She is 40 years old, 1 year younger than my father.",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Do you have any siblings? What’s his/her name?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text:
            "Yes, I do. I have 1 elder brother, David, and 1 younger sister, Mary.",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "Are you the oldest amongst your brothers and sisters?",
        type: TYPE.ONE_HUMAN,
        voice: "Hello Bob!"),
    Message(
        id: "0",
        text: "No, I’m not. I’m the second child in my family.",
        type: TYPE.TWO_HUMAN,
        voice: "Hello Bob!"),
  ];

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  int silencems;
  bool speakingState = false;
  final GlobalKey _menuKey = new GlobalKey();
  String _newVoiceText;
  int indexSpeaking = -1;
  String _now;
  Timer _everySecond;
  int readDone = -1;

  TtsState ttsState = TtsState.stopped;
  LearningMode learningMode = LearningMode.botVsPlayer;

  // get isPlaying => ttsState == TtsState.playing;
  // get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        if (speakingState && ttsState == TtsState.stopped) {
          // _now = DateTime.now().second.toString();
          readDone = indexSpeaking;
          indexSpeaking++;
        }
      });
      if (indexSpeaking >= listMessages.length - 1) {
        _everySecond.cancel();
      }
    });

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  initTts() {
    flutterTts = FlutterTts();
  }

  void _changeStatePlaying() {
    if (ttsState == TtsState.playing) {
      print("is Playing");
      flutterTts.stop();
    }
    setState(() {
      speakingState = !speakingState;
      ttsState = TtsState.stopped;
    });
  }

  void autoSpeech() {}

  void _read(String text) async {
    await flutterTts.stop();
    new Future.delayed(const Duration(milliseconds: 5), () async {
      if (text != null && text.isNotEmpty) {
        await flutterTts.speak(text.toLowerCase());
        setState(() {
          readDone = indexSpeaking;
        });
      }
    });
    if (text != null && text.isNotEmpty) {
      await flutterTts.speak(text.toLowerCase());
      setState(() {
        readDone = indexSpeaking;
      });
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  _showSnackBar() {
    final snackBar = new SnackBar(
      content: Text("Changed learning mode!"),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: "OK",
        onPressed: (){

        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Chat Screen"), actions: <Widget>[
        // action button
        // IconButton(
        //   icon: Icon(Icons.settings),
        //   onPressed: () {},
        // ),
        PopupMenuButton(
          onSelected: (String value) {
            print(value);
            switch (value) {
              case 'botVsBot':
                setState(() {
                  learningMode = LearningMode.botVsBot;
                });
                _showSnackBar();
                break;
              case 'botVsPlayer':
                setState(() {
                  learningMode = LearningMode.botVsPlayer;
                });
                _showSnackBar();
                break;
              case 'playerVsPlayer':
                setState(() {
                  learningMode = LearningMode.playerVsPlayer;
                });
                _showSnackBar();
                break;
              default:
            }
          },
          key: _menuKey,
          itemBuilder: (_) => <PopupMenuItem<String>>[
            new PopupMenuItem<String>(
                value: 'botVsBot', child: Text('Luyện nghe')),
            new PopupMenuItem<String>(
                value: 'botVsPlayer', child: Text('Luyện với Bot')),
            new PopupMenuItem<String>(
                value: 'playerVsPlayer', child: Text('Luyện nói 2 người')),
          ],
        )
      ]),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 60.0),
            itemCount: listMessages.length,
            itemBuilder: (context, index) {
              return _buildRow(
                listMessages[index],
                index,
                context,
              );
            }),
      ),
      bottomSheet: bottomControl(),
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

    if (speakingState && indexSpeaking == index && readDone != index) {
      switch (learningMode) {
        case LearningMode.botVsPlayer:
          if (alignment == MainAxisAlignment.start) {
            _read(textMessage);
          }
          break;
        case LearningMode.botVsBot:
          _read(textMessage);
          break;
        case LearningMode.playerVsPlayer:
          break;
        default:
      }
    }

    final marginLeft = alignment == MainAxisAlignment.start ? 10.0 : 50.0;
    final marginRight = alignment == MainAxisAlignment.start ? 50.0 : 10.0;

    double widthRow = MediaQuery.of(context).size.width * 0.8;
    return Row(
      mainAxisAlignment: alignment,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(textMessage);
            _read(textMessage);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: marginLeft, right: marginRight, top: 10.0),
            padding: const EdgeInsets.all(10.0),
            // width: c_width,
            constraints: BoxConstraints(minWidth: 100, maxWidth: widthRow),
            child: Text(textMessage),
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
    );
  }

  Widget bottomControl() {
    return Container(
      height: 50,
      // padding: EdgeInsets.only(bottom: 10.0),
      color: Colors.blueGrey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: _changeStatePlaying,
            child: Icon(
              speakingState
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_filled,
              color: Colors.blue,
              size: 40.0,
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
