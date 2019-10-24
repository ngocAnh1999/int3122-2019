import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/FlashCard.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';

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
        front: _buildCard(widget.flashCard.word, () => _flip(true)),
        back: _buildCard(widget.flashCard.meaning, () => _flip(false)),
      ),
    );
  }

  Widget _buildCard(String title, GestureTapCallback onTap) {
    return AspectRatio(
      aspectRatio: widget.ratio,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
