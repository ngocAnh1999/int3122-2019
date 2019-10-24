
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Image.asset('assets/images/quizlet.png'),
        ),
      )
    );
  }
}