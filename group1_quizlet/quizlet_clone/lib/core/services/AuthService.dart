import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizlet_clone/core/models/User.dart';
import 'package:quizlet_clone/core/services/UserService.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';
import 'package:quizlet_clone/core/utilities/UsernameFactory.dart';

class AuthService {
  static final AuthService instance = AuthService._();
  static final UserService _userService = UserService.instance;
  static final _auth = FirebaseAuth.instance;
  static final _facebookLogin = FacebookLogin();

  AuthService._();

  Future<FirebaseUser> getCurrentUser() async =>
      await _auth.currentUser();

  Future<User> logInWithFacebook() async {
    if (await _facebookLogin.isLoggedIn) _facebookLogin.logOut();
    final result = await _facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);

        final firebaseUser = await _firebaseLogIn(credential: credential);
        User fireStoreUser = await _userService.getUser(id: firebaseUser.uid);

        if (fireStoreUser == null) {
          var profile = await FacebookProfileGetter.getProfile(
              accessToken: result.accessToken.token);
          var newUsername = await UsernameFactory.getUsername(
              firstName: profile['first_name'], lastName: profile['last_name']);

          fireStoreUser = new User(
              facebookId: profile['id'],
              firstName: profile['first_name'],
              lastName: profile['last_name'],
              email: profile['email'],
              username: newUsername);
          await _userService.addUser(
              data: fireStoreUser.toJson(), id: firebaseUser.uid);
          fireStoreUser.id = firebaseUser.uid;
        }
        return fireStoreUser;
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        return null;
    }
    return null;
  }

  Future<FirebaseUser> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    return _firebaseLogIn(credential: credential);
  }

  Future<FirebaseUser> _firebaseLogIn({@required credential}) async {
    final FirebaseUser firebaseUser =
        (await _auth.signInWithCredential(credential)).user;
    assert(firebaseUser.email != null);
    assert(firebaseUser.displayName != null);
    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);
    return firebaseUser;
  }

  Future<void> firebaseLogOut() async {
    await _auth.signOut();
    await _facebookLogin.logOut();
  }
}
