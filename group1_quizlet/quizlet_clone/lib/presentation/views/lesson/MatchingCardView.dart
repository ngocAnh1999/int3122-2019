import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/services/FlashCardService.dart';
import 'package:quizlet_clone/core/utilities/ListShuffler.dart';
import 'package:quizlet_clone/presentation/views/lesson/MatchingCard.dart';
import 'package:quizlet_clone/presentation/views/lesson/MatchingCardWinnerView.dart';

const int MAXIMUM_NUMBER_OF_FLASH_CARDS = 6;
const int MAXIMUM_NUMBER_OF_MATCHING_CARDS = 12;
const int GRID_HEIGHT = 4;
const int GRID_WIDTH = 3;

class MatchingCardView extends StatefulWidget {
  final Lesson lesson;
  final FlashCardService _flashCardService = FlashCardService.instance;

  MatchingCardView({Key key, this.lesson}) : super(key: key);

  @override
  MatchingCardViewState createState() => new MatchingCardViewState();
}

class MatchingCardViewState extends State<MatchingCardView> {
  MatchingCard _currentCard;
  List<MatchingCard> _matchingCards = List();
  int _numberOfRemainingCards;
  int _falseAttempts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Ghép thẻ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: widget._flashCardService
              .getFlashCards(lessonId: widget.lesson.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                _createMatchingCards(flashCards: snapshot.data);
                return GridView.count(
                  padding: EdgeInsets.all(10),
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: _matchingCards,
                );
            }
            return null;
          },
        ));
  }

  void _createMatchingCards({@required List<FlashCard> flashCards}) {
    _currentCard = null;

    var newCards = new List<MatchingCard>();
    var random = new Random();
    var maximumNumberOfCards =
        (flashCards.length > MAXIMUM_NUMBER_OF_FLASH_CARDS)
            ? MAXIMUM_NUMBER_OF_FLASH_CARDS
            : flashCards.length;
    _numberOfRemainingCards = maximumNumberOfCards * 2;
    var chosenCards = [];
    for (int i = 0; i < maximumNumberOfCards; i++) {
      var chosenCard = random.nextInt(flashCards.length);
      while (chosenCards.contains(chosenCard)) {
        chosenCard = random.nextInt(flashCards.length);
      }
      var fc = flashCards[chosenCard];
      var wordCard = MatchingCard(
          term: fc.word,
          matchingTerm: fc.meaning,
          onClicked: _checkMatchedCards);

      var meaningCard = MatchingCard(
          term: fc.meaning,
          matchingTerm: fc.word,
          onClicked: _checkMatchedCards);

      newCards.addAll([wordCard, meaningCard]);
    }

    _matchingCards = ListShuffler.shuffle(items: newCards);
  }

  _checkMatchedCards(MatchingCard newCard) async {
    if (_currentCard == null) {
      _currentCard = newCard;
      newCard.click();
    } else if (_currentCard != newCard) {
      if (_currentCard.term == newCard.matchingTerm) {
        await Future.wait(
            [_currentCard.highlightThenFade(), newCard.highlightThenFade()]);
        _numberOfRemainingCards -= 2;
        if (_numberOfRemainingCards == 0) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MatchingCardWinnerView(falseAttempts: _falseAttempts, lesson: widget.lesson)));
        }
      } else {
        await Future.wait([_currentCard.warn(), newCard.warn()]);
        _falseAttempts += 1;
      }
      _currentCard = null;
    }
  }
}
