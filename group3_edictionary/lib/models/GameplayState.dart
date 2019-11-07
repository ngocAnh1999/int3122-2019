import 'package:flutter/foundation.dart';

class GameplayState extends ChangeNotifier {
  bool finished = false;
  int rightAnswer = 0;
  int wrongAnswer = 0;

  void answerRight(){
    this.rightAnswer = this.rightAnswer + 1;
  }

  void answerWrong(){
    this.wrongAnswer = this.wrongAnswer + 1;

  }

  void setFinished(bool finished){
    this.finished = finished;
    notifyListeners();
  }
}