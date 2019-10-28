import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchingCard extends StatefulWidget {
  final String term;
  final String matchingTerm;
  final onClicked;
  final matchingCardState = new MatchingCardState();

  MatchingCard(
      {Key key,
      @required this.term,
      @required this.matchingTerm,
      @required this.onClicked})
      : super(key: key);

  // ignore: missing_return
  void clear() {
    matchingCardState.clear();
  }

  void click() {
    matchingCardState.click();
  }

  Future<void> highlightThenFade() async {
    matchingCardState.highlight();
    await Future.delayed(Duration(milliseconds: 500));
    matchingCardState.fade();
  }

  Future<void> warn() async {
    matchingCardState.warn();
    await Future.delayed(Duration(milliseconds: 500));
    matchingCardState.clear();
  }

  @override
  MatchingCardState createState() => matchingCardState;
}

class MatchingCardState extends State<MatchingCard> {
  Color _background = Colors.white;
  bool _fade = false;

  void clear() {
    setState(() {
      _background = Colors.white;
    });
  }

  void click() {
    setState(() {
      _background = Colors.yellowAccent;
    });
  }

  void highlight() {
    setState(() {
      _background = Colors.greenAccent;
    });
  }

  void fade() {
    setState(() {
      _fade = true;
    });
  }

  void warn() {
    setState(() {
      _background = Colors.redAccent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedContainer(
            width: (_fade) ? 0 : 300,
            height: (_fade) ? 0 : 300,
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
                color: _background,
                border:
                    (_fade) ? null : Border.all(color: Colors.grey, width: 2)),
            child: FlatButton(
                child: Center(
                    child: Text((_fade) ? '' : widget.term,
                        style: TextStyle(fontSize: 16))),
                onPressed: () {
                  widget.onClicked(widget);
                })));
  }
}
