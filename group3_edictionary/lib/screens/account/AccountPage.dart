import 'package:flutter/material.dart';
import '../../shared/menubar/MenuBar.dart';
import '../../services/AuthService.dart';
import '../login-page/LoginPage.dart';

class AccountPage extends StatefulWidget{
  AccountPage({ Key key}) : super(key : key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final AuthService authService = AuthService();

  Future<Null> handleSignOut() async {
    await authService.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()), 
      ModalRoute.withName('/login')
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Tài khoản')),
      drawer: MenuBar(),
      body: Center(
        child: FlatButton(
          onPressed: handleSignOut,
          color: Colors.red[400],
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}