import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';

typedef void SwipedEventCallback(bool);

class FlashCardSecondTypeLayout extends StatefulWidget {
  final FlashCard flashCard;
  final double ratio;
  final SwipedEventCallback swipedEventCallback;

  FlashCardSecondTypeLayout(
      {Key key, this.flashCard, this.ratio, this.swipedEventCallback})
      : super(key: key);

  @override
  _FlashCardSecondTypeLayoutState createState() =>
      _FlashCardSecondTypeLayoutState();
}

class _FlashCardSecondTypeLayoutState extends State<FlashCardSecondTypeLayout>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;
  String learning_type = "Học lại";
  Color learning_color = Colors.yellow;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipView(
        animationController: _curvedAnimation,
        front: _buildCard(widget.flashCard.word, () => _flip(true)),
        back: _buildCard(widget.flashCard.meaning, () => _flip(false)),
      ),
    );
  }

  Widget _buildCard(String title, GestureTapCallback onTap) {
    return AspectRatio(
      aspectRatio: widget.ratio,
      child: Dismissible(
        key: Key(UniqueKey().toString()),
        child: Card(
          elevation: 4,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                onTap: onTap,
                child: ListTile(
                  leading: Column(
                    children: <Widget>[
                      Icon(Icons.arrow_back_ios, size: 25, color: Color(0xfff1c40f),),
                      SizedBox(height: 10,),
                      Text("Học lại", style: TextStyle(color: Color(0xfff1c40f)),)
                    ],
                  ),
                  trailing: Column(
                    children: <Widget>[
                      Icon(Icons.arrow_forward_ios, size: 25, color: Colors.green,),
                      SizedBox(height: 10,),
                      Text("Đã thuộc", style: TextStyle(color: Colors.green,))
                    ],
                  ),
                  title: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  backgroundColor: Color(0xfff1c40f),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Học lại ${title}",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ))
                .closed
                .then((reason) {
              widget.swipedEventCallback(false);
            });
          } else if (direction == DismissDirection.startToEnd) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.green,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Đã thuộc ${title}",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ))
                .closed
                .then((reason) {
              widget.swipedEventCallback(true);
            });
          }
        },
      ),
    );
  }
}
