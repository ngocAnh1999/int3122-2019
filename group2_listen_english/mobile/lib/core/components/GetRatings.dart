import 'package:flutter/material.dart';

class GetRatings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.star,
            size: 22.0,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            size: 22.0,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            size: 22.0,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            size: 22.0,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star_half,
            size: 18.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
