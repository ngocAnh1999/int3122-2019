import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:quizlet_clone/core/utilities/FlashCardImageGetter.dart';

class FlashCardLayout extends StatefulWidget {
  final FlashCard flashCard;
  final double ratio;

  FlashCardLayout({Key key, this.flashCard, this.ratio}) : super(key: key);

  @override
  _FlashCardLayoutState createState() => _FlashCardLayoutState();
}

class _FlashCardLayoutState extends State<FlashCardLayout>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

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
        front: _buildFront(widget.flashCard.word, () => _flip(true)),
        back: _buildBack(widget.flashCard.meaning, widget.flashCard.imageUrl,
            () => _flip(false)),
      ),
    );
  }

  Widget _buildBack(String title, String imageUrl, GestureTapCallback onTap) {
    return AspectRatio(
      aspectRatio: widget.ratio,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
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
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: (widget.flashCard.imageUrl != null)
                      ? Row(
                          children: <Widget>[
                            Container(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            (widget.flashCard.imageUrl != null)
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                FlashCardImageGetter.getImage(
                                                    imageUrl: imageUrl))),
                                  )
                                : SizedBox()
                          ],
                        )
                      : Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildFront(String title, GestureTapCallback onTap) {
    return AspectRatio(
      aspectRatio: widget.ratio,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
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
              child: Center(
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
    );
  }
}
