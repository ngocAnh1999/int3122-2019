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
  String _loginStatus = '';
  bool _authenticating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 100, 10, 50),
          child: Column(
            children: <Widget>[
              Center(
                  child: Container(
                      width: 200,
                      height: 60,
                      child: Image.asset('assets/images/quizlet_label.png'))),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.transparent, width: 1),
                  color: Colors.transparent,
                ),
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: _authenticating
                                  ? Colors.blueAccent.withOpacity(0.3)
                                  : Colors.blueAccent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FlatButton(
                              onPressed:
                                  _authenticating ? null : _logInWithFacebook,
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
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            height: 60,
                            decoration: BoxDecoration(
                              color: _authenticating
                                  ? Colors.redAccent.withOpacity(0.3)
                                  : Colors.redAccent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FlatButton(
                              onPressed:
                                  _authenticating ? null : _logInWithGoogle,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Đăng nhập với Google',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: 'Open Sans'))
                                ],
                              ),
                            ))),
                    Center(
                        child: (_authenticating)
                            ? Text(
                                '$_loginStatus',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            : null)
                  ],
                ),
              )
            ],
          ),
        ),
      )),
      bottomSheet: Container(
        height: 50,
        child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.copyright), Text('\tUET 2019')])),
      ),
    );
  }

  _logInWithFacebook() async {
    setState(() {
      _authenticating = true;
      _loginStatus = 'Đang xác thực...';
    });
    var user = await AuthService.instance
        .logInWithFacebook()
        .timeout(Duration(seconds: 60), onTimeout: () {
      setState(() {
        _authenticating = false;
        _loginStatus = 'Đăng nhập không thành công';
      });
      return;
    });
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeView()));
    } else {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _loginStatus = 'Đăng nhập không thành công';
        _authenticating = false;
      });
    }
  }

  // ignore: unused_element
  _logInWithGoogle() async {
    print('Google pressed');
  }
}
