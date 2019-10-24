import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/presentation/views/login/Login.dart';

void main() {
  runApp(MaterialApp(
    title: 'Facebook Login',
    home: LoginView(),
    theme: ThemeData.light(),
  ));
}
