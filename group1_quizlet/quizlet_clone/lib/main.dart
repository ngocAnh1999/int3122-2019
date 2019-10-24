import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/repositories/implementations/userRepositoryImpl.dart';
import 'package:quizlet_clone/core/services/UserService.dart';
import 'package:quizlet_clone/core/services/authService.dart';
import 'package:quizlet_clone/presentation/views/common/WaitingView.dart';
import 'package:quizlet_clone/presentation/views/home/HomeView.dart';
import 'package:quizlet_clone/presentation/views/login/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  var currentUser = await AuthService.getCurrentUser();
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
              future: new UserService(repository: new UserRepositoryImpl())
                  .getUser(id: currentUser.uid),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return BootView();
                  case ConnectionState.done:
                    return HomeView(currentUser: snapshot.data);
                }
                return null;
              },
            ),
      theme: ThemeData.light(),
    );
  }
}
