import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile/core/models/Message.dart';
import 'dart:async';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:mobile/views/screen/DummyData.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

enum TtsState { playing, stopped }
enum LearningMode { botVsBot, playerVsPlayer, botVsPlayer }

enum CHAT {
  CHAT_LEFT,
  CHAT_RIGHT,
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  int silencems;
  bool _isSpeaking = false;
  final GlobalKey _menuKey = new GlobalKey();

  int indexSpeaking = -1;
  String _now;
  Timer _everySecond;
  int readDone = -1;

  TtsState ttsState = TtsState.stopped;
  LearningMode learningMode = LearningMode.botVsPlayer;
  SpeechRecognition _speechRecognition;
  bool _isAvailableRecognition = false;
  bool _isListening = false;

  String resultText = "";

  @override
  initState() {
    super.initState();
    initSpeechRecognizer();
    initTts();
    _now = DateTime.now().second.toString();

    _everySecond = Timer.periodic(Duration(seconds: 3), (Timer t) {
      switch (learningMode) {
        case LearningMode.botVsBot:
          if (_isSpeaking && ttsState == TtsState.stopped && !_isListening) {
            setState(() {
              readDone = indexSpeaking;
              indexSpeaking++;
            });
          }
          break;
        case LearningMode.botVsPlayer:
          if (!_isListening &&
              listMessages[indexSpeaking].type == TYPE.ONE_HUMAN &&
              _isAvailableRecognition) {
            _speechRecognition
                .listen(locale: "en_US")
                .then((result) => print('$result'));
            setState(() {
              _isListening = !_isListening;
            });
          }
          break;
        case LearningMode.playerVsPlayer:
          break;
        default:
      }

      if (indexSpeaking >= listMessages.length - 1) {
        _everySecond.cancel();
        setState(() {
          indexSpeaking = -1;
        });
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

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailableRecognition = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() {
        _isListening = false;
        indexSpeaking++;
      }),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailableRecognition = result),
        );
  }

  void _onTapBottomControl() {
    if ((learningMode == LearningMode.botVsPlayer ||
            learningMode == LearningMode.playerVsPlayer) &&
        indexSpeaking == -1) {
      setState(() {
        indexSpeaking++;
      });
      return;
    }
    switch (learningMode) {
      case LearningMode.botVsBot:
        if (ttsState == TtsState.playing) {
          flutterTts.stop();
        }
        setState(() {
          _isSpeaking = !_isSpeaking;
          ttsState = TtsState.stopped;
        });
        break;
      case LearningMode.botVsPlayer:
        if (_isAvailableRecognition && !_isListening) {
          _speechRecognition
              .listen(locale: "en_US")
              .then((result) => print('$result'));
        }
        setState(() {
          _isListening = !_isListening;
        });
        break;
      case LearningMode.playerVsPlayer:
        setState(() {
          _isListening = !_isListening;
        });
        break;
      default:
    }
  }

  similarityChecker(String origin, String record) {
    List<String> arrayOrigin = origin.split(' ').toList();
    List<String> arrayRecord = record.split(' ').toList();
    int score = 0;
    for (int i = 0; i < arrayRecord.length; i++) {
      for (int j = 0; j < arrayOrigin.length; j++) {
        if (arrayRecord[i] == arrayOrigin[j]) {
          score++;
        }
      }
    }
    return score / arrayOrigin.length;
  }

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
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  ValueNotifier<LearningMode> _selectedItem =
      new ValueNotifier<LearningMode>(LearningMode.botVsPlayer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Chat Screen"), actions: <Widget>[
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
              value: 'botVsBot',
              child: RadioListTile<LearningMode>(
                title: Text("Luyện nghe"),
                value: LearningMode.botVsBot,
                groupValue: learningMode,
              ),
            ),
            new PopupMenuItem<String>(
                value: 'botVsPlayer',
                child: RadioListTile<LearningMode>(
                  title: Text("Luyện với bot"),
                  value: LearningMode.botVsPlayer,
                  groupValue: learningMode,
                )),
            new PopupMenuItem<String>(
              value: 'playerVsPlayer',
              child: RadioListTile<LearningMode>(
                title: Text("Luyện nói 2 người"),
                value: LearningMode.playerVsPlayer,
                groupValue: learningMode,
              ),
            ),
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

    if (_isSpeaking && indexSpeaking == index && readDone != index) {
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
            _read(textMessage);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: marginLeft, right: marginRight, top: 10.0),
            padding: const EdgeInsets.all(10.0),
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
    IconData iconBottom;
    Color iconColor = Colors.blue;
    switch (learningMode) {
      case LearningMode.botVsBot:
        iconBottom =
            _isSpeaking ? Icons.pause_circle_filled : Icons.play_circle_filled;
        break;
      case LearningMode.botVsPlayer:
        iconBottom = _isListening ? Icons.mic_none : Icons.mic_off;
        iconColor = _isListening ? Colors.red : Colors.blue;
        break;
      case LearningMode.playerVsPlayer:
        iconBottom = _isListening ? Icons.mic_none : Icons.mic_off;
        iconColor = _isListening ? Colors.red : Colors.blue;
        break;
      default:
    }

    if ((learningMode == LearningMode.botVsPlayer ||
            learningMode == LearningMode.playerVsPlayer) &&
        indexSpeaking == -1) {
      iconBottom = Icons.play_circle_filled;
      iconColor = Colors.blue;
    }
    return Container(
      height: learningMode != LearningMode.botVsBot ? 100 : 50,
      child: Column(
        children: <Widget>[
          learningMode != LearningMode.botVsBot
              ? Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Text(
                    resultText,
                    style: TextStyle(fontSize: 24.0),
                  ),
                )
              : Container(
                  height: 0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                child: Icon(iconBottom),
                onPressed: _onTapBottomControl,
                backgroundColor: iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
