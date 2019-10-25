import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/services/AuthService.dart';
import 'package:quizlet_clone/core/services/UserService.dart';
import 'package:quizlet_clone/presentation/views/common/BootView.dart';
import 'package:quizlet_clone/presentation/views/home/HomeView.dart';
import 'package:quizlet_clone/presentation/views/login/LoginView.dart';

void main() async {
  var currentUser = await AuthService.instance.getCurrentUser();
  runApp(QuizletCloneApp(currentUser: currentUser));
}

class QuizletCloneApp extends StatelessWidget {
  final FirebaseUser currentUser;

  QuizletCloneApp({this.currentUser}) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizlet Clone',
      home: (currentUser == null)
          ? LoginView()
          : FutureBuilder(
              future: UserService.instance.getUser(id: currentUser.uid),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return BootView();
                  case ConnectionState.done:
                    return HomeView();
                }
                return null;
              },
            ),
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
