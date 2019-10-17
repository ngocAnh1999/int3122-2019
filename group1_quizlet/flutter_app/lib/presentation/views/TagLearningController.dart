import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/presentation/layouts/FinishLearningLayout.dart';
import 'package:flutter_app/presentation/layouts/FlashCardLayout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

String APPBAR_TITLE = "Thẻ ghi nhớ";

class TagLearningController extends StatefulWidget {
  final Lesson lesson;

  TagLearningController({Key key, this.lesson}) : super(key: key);

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
          icon: Icon(Icons.close, color: Colors.black54,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("$cardIndex/${widget.lesson.vocabs.length}", style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
      ),
      body: Swiper(
        onIndexChanged: (index) {
          swipeCard(index);
          setCount();
          if (count == widget.lesson.vocabs.length) {
            resetCount();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new FinishLearningLayout()));
          }
        },
        itemBuilder: (BuildContext context, int index) {
          return new FlashCardLayout(
            flashCard: widget.lesson.vocabs[index],
            ratio: 0.8,
          );
        },
        itemCount: widget.lesson.vocabs.length,
        itemWidth: 300.0,
        itemHeight: 400.0,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
}
