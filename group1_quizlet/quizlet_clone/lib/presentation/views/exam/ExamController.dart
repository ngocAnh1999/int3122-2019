import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/presentation/views/exam/ExamFinishLayout.dart';
import 'package:quizlet_clone/presentation/views/exam/AnswerLayout.dart';
import 'package:quizlet_clone/presentation/views/exam/ChooseBestAnswerType.dart';
import 'package:quizlet_clone/presentation/views/exam/EnterAnswerType.dart';
import 'package:quizlet_clone/presentation/views/exam/TrueFalseType.dart';

class ExamController extends StatefulWidget {
  final List<FlashCard> flashCards;

  ExamController({Key key, this.flashCards}) : super(key: key);

  @override
  ExamControllerState createState() => new ExamControllerState();
}

class ExamControllerState extends State<ExamController> {
  int index = 0;
  int trueAnswers = 0;
  List<Widget> exams = null;
  List<AnswerLayout> answerlayouts = null;

  void increaseIndex() {
    setState(() {
      index++;
    });
  }

  void resetIndex() {
    setState(() {
      index = 0;
    });
  }

  List<String> getAnswerOutlineButton(int key, List<FlashCard> newFlashCards) {
    int length = min(4, newFlashCards.length);
    List<String> words = List.filled(length, "");
    List<int> visitedIndex = new List<int>();
    List<String> visitedWord = new List<String>();

    int keyIndex = Random().nextInt(length);
    visitedIndex.add(keyIndex);
    visitedWord.add(newFlashCards[key].word);

    words[keyIndex] = newFlashCards[key].word;
    for (int i = 0; i < length - 1; i++) {
      keyIndex = Random().nextInt(length);
      while (visitedIndex.contains(keyIndex)) {
        keyIndex = Random().nextInt(length);
      }
      String word = newFlashCards[Random().nextInt(newFlashCards.length)].word;
      while (visitedWord.contains(word)) {
        word = newFlashCards[Random().nextInt(newFlashCards.length)].word;
      }
      words[keyIndex] = word;
      visitedIndex.add(keyIndex);
      visitedWord.add(word);
    }
    return words;
  }

  List<FlashCard> swapIndex() {
    var visited = List.filled(widget.flashCards.length, false);
    List<FlashCard> newFlashCards = List<FlashCard>();
    for (int index = 0; index < widget.flashCards.length; index++) {
      var random = new Random();
      int key = random.nextInt(widget.flashCards.length);
      while (visited[key]) {
        key = random.nextInt(widget.flashCards.length);
      }
      visited[key] = true;
      newFlashCards.add(widget.flashCards[key]);
    }
    visited = List.filled(widget.flashCards.length, false);
    return newFlashCards;
  }

  List<Widget> splitExamType() {
    int ENTER_ANSWER_RANGE = (widget.flashCards.length * 0.4).floor();
    int CHOOSE_BEST_ANSWER_RANGE = (widget.flashCards.length * 0.7).floor();
    var listWidgets = List<Widget>();
    List<FlashCard> newFlashCards = swapIndex();
    for (int index = 0; index < newFlashCards.length; index++) {
      if (index <= ENTER_ANSWER_RANGE) {
        var widget = new EnterAnswerType(
          flashCard: newFlashCards[index],
          answerCallback: (answer, isTrue) async {
            if (isTrue) trueAnswers++;
            var userAnswer = new AnswerLayout(
              examType: ExamType.ENTER_ANSWER,
              word: newFlashCards[index].word,
              meaning: newFlashCards[index].meaning,
              true_answer: newFlashCards[index].meaning,
              user_answer: answer,
            );
            answerlayouts.add(userAnswer);
            if (index < exams.length - 1) {
              increaseIndex();
            } else {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ExamFinishLayout(
                        trueAnswers: trueAnswers,
                        count: exams.length,
                        answerLayouts: answerlayouts,
                      )));
              exams = splitExamType();
              trueAnswers = 0;
              answerlayouts.clear();
              resetIndex();
            }
          },
        );
        listWidgets.add(widget);
      } else if (index > ENTER_ANSWER_RANGE &&
          index <= CHOOSE_BEST_ANSWER_RANGE) {
        var widget = new ChooseBestAnswerType(
          meaning: newFlashCards[index].meaning,
          words: getAnswerOutlineButton(index, newFlashCards),
          anwers: newFlashCards[index].word,
          answerCallback: (answer, isTrue) async {
            if (isTrue) trueAnswers++;
            var userAnswer = new AnswerLayout(
              examType: ExamType.CHOOSE_BEST_ANSWER,
              word: newFlashCards[index].meaning,
              meaning: newFlashCards[index].word,
              true_answer: newFlashCards[index].word,
              user_answer: answer,
            );
            answerlayouts.add(userAnswer);
            if (index < exams.length - 1) {
              increaseIndex();
            } else {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ExamFinishLayout(
                        trueAnswers: trueAnswers,
                        count: exams.length,
                        answerLayouts: answerlayouts,
                      )));
              exams = splitExamType();
              trueAnswers = 0;
              answerlayouts.clear();
              resetIndex();
            }
          },
        );
        listWidgets.add(widget);
      } else if (index > CHOOSE_BEST_ANSWER_RANGE &&
          index < widget.flashCards.length) {
        int key = Random().nextInt(newFlashCards.length);
        bool meaningTrue = Random().nextBool();
        String meaning = (meaningTrue)
            ? newFlashCards[index].meaning
            : newFlashCards[key].meaning;
        var widget = new TrueFalseType(
          word: newFlashCards[index].word,
          meaning: meaning,
          answer: meaning == newFlashCards[index].meaning,
          answerCallback: (answer, isTrue) async {
            if (isTrue) trueAnswers++;
            var userAnswer = new AnswerLayout(
              examType: ExamType.TRUE_FALSE,
              word: newFlashCards[index].word,
              meaning: meaning,
              true_answer: (meaning == newFlashCards[index].meaning) ? "Đúng" : "Sai",
              user_answer: answer,
            );
            answerlayouts.add(userAnswer);
            if (index < exams.length - 1) {
              increaseIndex();
            } else {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ExamFinishLayout(
                        trueAnswers: trueAnswers,
                        count: exams.length,
                        answerLayouts: answerlayouts,
                      )));
              exams = splitExamType();
              trueAnswers = 0;
              answerlayouts.clear();
              resetIndex();
            }
          },
        );
        listWidgets.add(widget);
      }
    }
    return listWidgets;
  }

  @override
  void initState() {
    exams = splitExamType();
    answerlayouts = new List<AnswerLayout>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 70 / 100,
          lineHeight: 20.0,
          center: Text(
              "${((index / widget.flashCards.length) * 100).toStringAsFixed(0)}%"),
          percent: index / widget.flashCards.length,
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
        ),
        leading: IconButton(
          color: Colors.black54,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: exams[index],
    );
  }
}
