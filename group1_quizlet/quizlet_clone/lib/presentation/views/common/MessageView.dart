import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  final String message;

  MessageView({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$message')),
    );
  }
}
