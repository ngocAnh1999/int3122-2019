import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:quizlet_clone/presentation/views/login/LoginView.dart';

class UserView extends StatefulWidget {
  @override
  UserViewState createState() => UserViewState();
}

class UserViewState extends State<UserView> {
  void _signOut() async {
    //print("Good bye");
    await FirebaseAuth.instance.signOut();
    await FacebookLogin().logOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        ),
        Center(
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.transparent)),
            child: FlatButton(
              child: Text('Sign out',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: _signOut,
            ),
          ),
        )
      ],
    );
  }
}
