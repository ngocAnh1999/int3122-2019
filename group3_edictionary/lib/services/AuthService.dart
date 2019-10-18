import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/User.dart';

class AuthService {
	final GoogleSignIn _googleSignIn = new GoogleSignIn();
	// final FirebaseAuth _auth = FirebaseAuth.instance;

	Future<FirebaseUser> signInWithGoogle() async {
		GoogleSignInAccount googleUser = await _googleSignIn.signIn();
		GoogleSignInAuthentication authentication = await googleUser.authentication;

		AuthCredential credential = GoogleAuthProvider.getCredential(
			accessToken: authentication.accessToken,
			idToken: authentication.idToken
		);
    print(credential);

		FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    print(user);
    return user;
	}		

  Future<Null> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    return;
  }

  Future<bool> isSignedIn() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }
}