import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardSecondTypeLayout.dart';
import 'package:quizlet_clone/presentation/views/tag/TagFinishLayout.dart';

String APPBAR_TITLE = "Thẻ ghi nhớ";

class TagLearningController extends StatefulWidget {
  final Lesson lesson;
  final List<FlashCard> flashCards;

  TagLearningController({Key key, this.lesson, this.flashCards})
      : super(key: key);

  @override
  TagLearningState createState() => new TagLearningState();
}

class TagLearningState extends State<TagLearningController> {
  int count = 0;
  int wrong = 0;
  List<FlashCard> relearnFlashCard = new List<FlashCard>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          APPBAR_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: widget.flashCards.map((FlashCard flashCard) {
              return FlashCardSecondTypeLayout(
                ratio: 0.8,
                swipedEventCallback: (learnt) async {
                  if (!learnt) {
                    wrong++;
                    relearnFlashCard.add(widget.flashCards[count]);
                  }
                  ;
                  count++;
                  if (count == widget.flashCards.length) {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new TagFinishLayout(
                                  wrong: wrong,
                                  relearnFlashCard: relearnFlashCard,
                                )));
                    count = 0;
                    wrong = 0;
                    relearnFlashCard.clear();
                  }
                },
                flashCard: flashCard,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
