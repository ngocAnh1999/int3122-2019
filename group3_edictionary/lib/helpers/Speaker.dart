import 'package:flutter_tts/flutter_tts.dart';

class Speaker {
  FlutterTts flutterTts = new FlutterTts();

  Future<Null> speak(String content) async {
    await flutterTts.setVolume(1.0);
    var result = await flutterTts.speak(content);
    print('Run result: $result');
  }
}