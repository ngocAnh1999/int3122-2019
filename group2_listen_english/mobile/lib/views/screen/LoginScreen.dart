import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  String _email,_password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              // ignore: missing_return
              validator: (input){
                if (input.isEmpty){
                  return 'Please type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: "Email"
              ),
            ),
            TextFormField(
              // ignore: missing_return
              validator: (input){
                if (input.length < 6){
                  return 'Your password needs to be at least 6 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  labelText: "Password"
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: (){

              },
              child: Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    // TODO validate
    final formState = _formkey.currentState;
    if (formState.validate()){
      formState.save();
      FirebaseUser user = FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password) as FirebaseUser;

    }
  }
}