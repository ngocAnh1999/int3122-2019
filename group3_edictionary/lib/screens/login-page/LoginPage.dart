import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/HomePage.dart';
import '../../services/AuthService.dart';
import '../../services/UserService.dart';
import 'package:overlay_support/overlay_support.dart';

class LoginPage extends StatefulWidget{
  LoginPage({ Key key}) : super(key : key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final UserService _userService = new UserService();
  final AuthService _authService = new AuthService();

  bool loading = false;

  @override
  void initState(){
    super.initState();
    checkUserSignedIn();
  }

  void checkUserSignedIn() async {
    this.setState(() {
      loading = true;
    });
  
    bool isSignedIn = await _authService.isSignedIn();
    if (isSignedIn){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      FirebaseUser currentUser = await _authService.getCurrentUser();
      await preferences.setString('gid', currentUser.uid);
      await preferences.setString('name', currentUser.displayName);
      await preferences.setString('email', currentUser.email);
      await preferences.setString('avatar_url', currentUser.photoUrl); 

      print('Already signed in.');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), 
        ModalRoute.withName('/home')
      );
    }
    else print('Have not signed in yet.');

    this.setState((){
      loading = false;
    });
  }

  Future<Null> handleSignIn() async {
    this.setState((){
      loading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    FirebaseUser user = await _authService.signInWithGoogle();
    if (user == null){
      this.setState((){
        loading = false;
      });
      return showSimpleNotification(
        Text("Unable to sign in."),
        background: Colors.red,
        autoDismiss: true
      );
    }
  
    List<dynamic> documents = await _userService.findUsersById(user.uid);
    if (documents.length == 0){
      await _userService.save(user);
    }

    await preferences.setString('gid', user.uid);
    await preferences.setString('name', user.displayName);
    await preferences.setString('email', user.email);
    await preferences.setString('avatar_url', user.photoUrl);
    
    toast('Welcome ${user.displayName}');

    print('Successfully signed in.');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage()), 
      ModalRoute.withName('/home')
    );

    this.setState((){
      loading = false;
    });
  }

  Future<Null> handleSkip() async {
    print('Skipping signing in.');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage()), 
      ModalRoute.withName('/home')
    );
  }

	@override
	Widget build(BuildContext context) {
    var appBar = new AppBar(title: new Text('Sign In'));
		return new Scaffold(
			appBar: appBar,
			body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('Để lưu kết quả học tập, bạn cần đăng nhập.', style: TextStyle(color : Colors.black54, fontSize: 12), ),
                    ),
                    FlatButton(
                      onPressed: handleSignIn,
                      color: Colors.red[400],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.account_circle, color: Colors.white),
                          Text(' ĐĂNG NHẬP VỚI GOOGLE', style: TextStyle(color: Colors.white)) 
                        ],  
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child : GestureDetector(
                        onTap: handleSkip,
                        child: Text('ĐĂNG NHẬP SAU', style: TextStyle(color: Colors.blue, fontSize: 12))
                      )
                    )
                  ]
                ),
              ),
              Divider(thickness: 1)
            ],
          ),
          loading ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.7,
                child: ModalBarrier(dismissible: false, color : Colors.black),
              ),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ) : Stack()
        ],
      )
       
		);
	}
}