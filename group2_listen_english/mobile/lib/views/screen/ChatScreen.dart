import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile/core/models/Message.dart';
import 'dart:async';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:mobile/views/screen/DummyData.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:mobile/core/models/TimeCustom.dart';

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

enum PlayerAudioState { stopped, playing, paused }

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AudioPlayer _audioPlayer = new AudioPlayer();
  PlayerAudioState playerAudioState = PlayerAudioState.stopped;
  Duration duration;
  Duration position;
  get isPlaying => playerAudioState == PlayerAudioState.playing;
  get isPaused => playerAudioState == PlayerAudioState.paused;
  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';
  bool isMuted = false;
  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  FlutterTts flutterTts;
  bool _isSpeaking = false;
  final GlobalKey _menuKey = new GlobalKey();
  int indexSpeaking = -1;
  Timer _everySecond;
  TtsState ttsState = TtsState.stopped;
  LearningMode learningMode = LearningMode.botVsBot;

  SpeechRecognition _speechRecognition;
  bool _isAvailableRecognition = false;
  bool _isListening = false;
  String resultText = "";

  @override
  initState() {
    super.initState();
    initSpeechRecognizer();
    initTts();
    initAudioPlayer();

    _everySecond = Timer.periodic(
        Duration(seconds: learningMode == LearningMode.botVsBot ? 6 : 10),
        (Timer t) {
      switch (learningMode) {
        case LearningMode.botVsBot:
          break;
        case LearningMode.botVsPlayer:
          if (!_isListening &&
              listMessages[indexSpeaking].type == TYPE.TWO_HUMAN &&
              _isAvailableRecognition) {
            _speechRecognition
                .listen(locale: "en_US")
                .then((result) => print('$result'));
            setState(() {
              _isListening = !_isListening;
            });
          } else if (!_isSpeaking &&
              listMessages[indexSpeaking].type == TYPE.ONE_HUMAN) {}
          break;
        case LearningMode.playerVsPlayer:
          if (!_isListening && _isAvailableRecognition) {
            _speechRecognition
                .listen(locale: "en_US")
                .then((result) => print('$result'));
            setState(() {
              _isListening = !_isListening;
            });
          }
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

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    _audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    _audioPlayer = new AudioPlayer();
    _positionSubscription = _audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = _audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerAudioState = PlayerAudioState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
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

    // _speechRecognition.setRecognitionCompleteHandler(
    //   () => setState(() {
    //     _isListening = false;
    //   }),
    // );

    _speechRecognition.setRecognitionCompleteHandler(() => {
          setState(() {
            _isListening = false;
          }),
          Future.delayed(const Duration(seconds: 7), () {
            if (!_isListening) {
              setState(() {
                indexSpeaking++;
              });
            }
          })
        });

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
    }
    switch (learningMode) {
      case LearningMode.botVsBot:
        if (ttsState == TtsState.playing) {
          flutterTts.stop();
        }
        playerAudioState == PlayerAudioState.paused
            ? playAudio(
                "https://s.sachmem.vn/public/audio/TA2V2SHS/R4-L1-1.mp3")
            : pauseAudio();
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
        _speechRecognition.stop();
        _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
        );
        if (_isAvailableRecognition && !_isListening) {
          _speechRecognition
              .listen(locale: "en_US")
              .then((result) => print('$result'));
          setState(() {
            _isListening = !_isListening;
          });
        }

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

  Future playAudio(kUrl) async {
    await _audioPlayer.play(kUrl);
    setState(() {
      playerAudioState = PlayerAudioState.playing;
    });
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    setState(() => playerAudioState = PlayerAudioState.paused);
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      playerAudioState = PlayerAudioState.stopped;
      // position = new Duration();
    });
  }

  Future mute(bool muted) async {
    await _audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerAudioState = PlayerAudioState.stopped);
  }

  void _read(String text) async {
    await flutterTts.stop();
    new Future.delayed(const Duration(milliseconds: 5), () async {
      if (text != null && text.isNotEmpty) {
        await flutterTts.speak(text.toLowerCase());
      }
    });
    if (text != null && text.isNotEmpty) {
      await flutterTts.speak(text.toLowerCase());
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
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            playerAudioState == PlayerAudioState.paused
                ? playAudio(
                    "https://s.sachmem.vn/public/audio/TA2V2SHS/R4-L1-1.mp3")
                : pauseAudio();
          },
        ),
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
                stopAudio();
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
            // new PopupMenuItem<String>(
            //     value: 'botVsPlayer',
            //     child: RadioListTile<LearningMode>(
            //       title: Text("Luyện với bot"),
            //       value: LearningMode.botVsPlayer,
            //       groupValue: learningMode,
            //     )),
            new PopupMenuItem<String>(
              value: 'playerVsPlayer',
              child: RadioListTile<LearningMode>(
                title: Text("Luyện nói"),
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
    if (position != null &&
        message.starttime.minute ==
            int.parse(double.parse(position.toString().substring(2, 4))
                .toStringAsFixed(0)) &&
        message.starttime.second ==
            int.parse(double.parse(position.toString().substring(5))
                .toStringAsFixed(0))) {
      indexSpeaking = index;
    }

    final backgroundMessageColor =
        indexSpeaking == index ? Colors.red[100] : Colors.blue[100];
    final borderMessageColor =
        indexSpeaking == index ? Colors.red : Colors.transparent;
    final textMessage = message.text;
    final alignment = message.type == TYPE.ONE_HUMAN
        ? MainAxisAlignment.start
        : MainAxisAlignment.end;

    if (!_isSpeaking && indexSpeaking == index) {
      switch (learningMode) {
        case LearningMode.botVsPlayer:
          if (message.type == TYPE.ONE_HUMAN) {
            // _read(textMessage);
          }
          break;
        case LearningMode.botVsBot:
          // _read(textMessage);
          break;
        case LearningMode.playerVsPlayer:
          break;
        default:
      }
    }

    position != null
        ? print("Check positionText = " + positionText.toString())
        : null;

    // print("Check starttime = " + message.starttime.toString());

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
        iconBottom = playerAudioState == PlayerAudioState.playing
            ? Icons.pause_circle_filled
            : Icons.play_circle_filled;
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        child: Text(
                          resultText,
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 36,
                        ),
                      )
                    ],
                  ))
              : Container(
                  height: 0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (learningMode == LearningMode.botVsBot && position != null)
                Container(
                  child: Text(
                      position != null
                          ? "${positionText ?? ''} / ${durationText ?? ''}"
                          : duration != null ? durationText : '',
                      style: new TextStyle(fontSize: 16.0)),
                ),
              if (learningMode == LearningMode.playerVsPlayer)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexSpeaking--;
                    });
                  },
                  child: Icon(Icons.navigate_before),
                ),
              FloatingActionButton(
                mini: true,
                child: Icon(iconBottom),
                onPressed: _onTapBottomControl,
                backgroundColor: iconColor,
              ),
              if (learningMode == LearningMode.playerVsPlayer)
                GestureDetector(
                  onTap: () {
                    _speechRecognition.stop();
                    _speechRecognition.setRecognitionStartedHandler(
                      () => setState(() => _isListening = true),
                    );
                    if (_isAvailableRecognition && !_isListening) {
                      _speechRecognition
                          .listen(locale: "en_US")
                          .then((result) => print('$result'));
                      setState(() {
                        _isListening = !_isListening;
                      });
                    }
                    setState(() {
                      indexSpeaking++;
                    });
                  },
                  child: Icon(Icons.navigate_next),
                )
            ],
          ),
        ],
      ),
    );
  }
}
