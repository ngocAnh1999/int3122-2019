import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text('please wait!'),
    );
//    return LoadingIndicator(
//      indicatorType: Indicator.squareSpin,
//      color: Colors.blueAccent
//    );
  }
}