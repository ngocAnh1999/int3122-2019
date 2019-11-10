import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/core/models/User.dart';
import 'package:mobile/core/services/StrapiRequest.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<User> signInFromStrapi( String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> signUpFromStrapi(String username, String email, String password);

  Future<String> signInFB();

  Future<String> signInGG();

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final StrapiReq strapiReq = new StrapiReq();

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
    return null;
  }

  @override
  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Future<String> signInFB() async {
    final facebookLogin = new FacebookLogin();
    final res = await facebookLogin.logIn(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: res.accessToken.token);
    final FirebaseUser firebaseUser = (await _firebaseAuth.signInWithCredential(credential)).user;
    return firebaseUser.uid;
  }

  @override
  Future<String> signInGG() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser firebaseUser =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    return firebaseUser.uid;
  }

  @override
  Future<User> signInFromStrapi(String email, String password) async {
    Map<String,dynamic> data = {
      "identifier": email,
      "password": password,
    };
    final response = await strapiReq.request("auth/local",body: data,method: 'POST');
    if (response.statusCode == 200) {
      return User.fromMappedJson((json.decode(response.body))["user"]);
    } else {
      throw Exception('Unable to sign in');
    }
  }

  @override
  Future<User> signUpFromStrapi(String username, String email, String password) async {
    Map<String,String> data = {
      "username": username,
      "email": email,
      "password": password
    };
    final response = await strapiReq.request("auth/local/register",body: data,method: 'POST');
    if (response.statusCode == 200) {
      return User.fromMappedJson((json.decode(response.body))["user"]);
    } else {
      throw Exception('Unable to sign up');
    }
  }

}