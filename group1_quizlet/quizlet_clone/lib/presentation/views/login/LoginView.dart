import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizlet_clone/core/services/AuthService.dart';

import '../home/HomeView.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  String _loginResult = 'waiting';
  bool _authenticating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            height: 500,
            width: 400,
            child: Column(
              children: <Widget>[
                Center(
                    child: Container(
                        width: 200,
                        height: 60,
                        child: Image.asset('assets/images/quizlet_label.png'))),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Center(
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Open Sans'),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.transparent, width: 1),
                    color: Colors.indigo,
                  ),
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              height: 60,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FlatButton(
                                onPressed: () => _logInWithFacebook(),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Đăng nhập với Facebook',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Open Sans'))
                                  ],
                                ),
                              ))),
                      Center(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                              height: 60,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FlatButton(
                                onPressed: () => _logInWithGoogle(),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.redAccent,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Đăng nhập với Google',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'Open Sans'))
                                  ],
                                ),
                              ))),
                      Center(
                          child: (_authenticating)
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white)
                              : null)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomSheet: Container(
            height: 50,
            child: Center(
                child: Text('Status: $_loginResult',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Open Sans',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w100)))));
  }

  _logInWithFacebook() async {
    setState(() {
      _authenticating = true;
    });
    var user = await AuthService.logInWithFacebook();
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeView()));
    } else {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _loginResult = 'error';
        _authenticating = false;
      });
    }
  }

  // ignore: unused_element
  _logInWithGoogle() async {
    print('Google pressed');
  }
}
