import 'package:flutter/material.dart';
import 'package:mobile/core/components/ViewBook.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/services/BookServices.dart';
import 'package:mobile/core/services/authentication.dart';
import 'package:mobile/views/screen/AboutScreen.dart';
import 'package:mobile/views/widgets/BookList.dart';
import 'package:mobile/views/screen/ResultUserScreen.dart';
import 'package:mobile/views/screen/SettingsScreen.dart';
import 'package:mobile/views/screen/UserProfileScreen.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  List<Book> itemList;

  void logout() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  _showSnackBar() {
    final snackBar = new SnackBar(
      content: Text("Updated new books!!"),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listen & Speak English'),
      ),
      body: BookList(),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Text(
                      "Nghe nói - Sách cứng",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Sách'),
                    onTap: () {
                      Navigator.pop(context);
                      _showSnackBar();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Người dùng'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.insert_chart),
                    title: Text('Kết quả học'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultUserScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Giới thiệu'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log out'),
                    onTap: logout,
                  ),
                ],
              ),
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text('Help and Feedback'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text("Version: 1.0"),
                        ),
                      ],
                    ))))
          ],
        ),
      ),
    );
  }

}
