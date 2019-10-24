import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizlet_clone/core/services/authService.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  String _loginResult = 'Not logged in';
  String _userEmail = 'unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
          ),
          Center(
            child: Text(
              'Quizlet Clone',
              style: TextStyle(fontSize: 32, color: Colors.blueAccent),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          Center(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          Center(
              child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: FlatButton(
                      onPressed: () => _logInWithFacebook(),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Login with Facebook',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                      color: Colors.indigo))),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          ),
          Center(
            child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(5)),
                child: FlatButton(
                    onPressed: () => _logInWithGoogle(),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.google,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Login with Google(error)',
                            style: TextStyle(fontSize: 20, color: Colors.black))
                      ],
                    ),
                    color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text('Status: $_loginResult',
                style: TextStyle(fontSize: 20, color: Colors.redAccent)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text('User email: $_userEmail',
                style: TextStyle(fontSize: 20, color: Colors.redAccent)),
          )
        ],
      ),
    );
  }

  _logInWithFacebook() async {
    var user = await AuthService.logInWithFacebook();
    if (user != null) {
      setState(() {
        _loginResult = 'Logged in with Facebook';
        _userEmail = user.email;
      });
    } else
      setState(() {
        _loginResult = 'Unable to log in with Facebook';
        _userEmail = 'unknown';
      });
  }

  _logInWithGoogle() async {
    var user = await AuthService.logInWithGoogle();
    if (user != null) {
      setState(() {
        _loginResult = 'Logged in with Facebook';
        _userEmail = user.email;
      });
    } else
      setState(() {
        _loginResult = 'Unable to log in with Facebook';
        _userEmail = 'unknown';
      });
  }
}
