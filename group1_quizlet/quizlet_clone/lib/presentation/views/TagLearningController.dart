import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/presentation/layouts/FinishLearningLayout.dart';
import 'package:quizlet_clone/presentation/layouts/FlashCardLayout.dart';

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
  int cardIndex = 1;
  int count = 0;

  void swipeCard(int index) {
    setState(() {
      cardIndex = index + 1;
    });
  }

  void setCount() {
    setState(() {
      count++;
    });
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "$cardIndex/${widget.flashCards.length}",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Swiper(
        onIndexChanged: (index) {
          swipeCard(index);
          setCount();
          if (count == widget.flashCards.length) {
            resetCount();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new FinishLearningLayout()));
          }
        },
        itemBuilder: (BuildContext context, int index) {
          return new FlashCardLayout(
            flashCard: widget.flashCards[index],
            ratio: 0.8,
          );
        },
        itemCount: widget.flashCards.length,
        itemWidth: 300.0,
        itemHeight: 400.0,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
}
