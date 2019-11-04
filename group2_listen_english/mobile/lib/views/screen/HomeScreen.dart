import 'package:flutter/material.dart';
import 'package:mobile/core/components/ViewBook.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/services/authentication.dart';
import 'package:mobile/views/screen/AboutScreen.dart';
import 'package:mobile/views/screen/ResultUserScreen.dart';
import 'package:mobile/views/screen/SettingsScreen.dart';
import 'package:mobile/views/screen/UserProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    itemList = _itemList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Listen & Speak English'),
      ),
      // body: _gridView(),
      body: StreamBuilder(
        stream: Firestore.instance.collection("EnglishBook").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(
              child: Text("Loading"),
            );

          // List<Book> listBooks;
          // for (int i = 0; i < snapshot.data.documents.length; i++) {
          //   var parsedJson = json.decode(snapshot.data.documents[i].toString());
          //   var book = Book.fromJson(parsedJson);
          //   listBooks.add(book);
          // }

          // Todo

          return GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(4.0),
            childAspectRatio: 7.2 / 12.0,
            children: itemList
                .map(
                  (Book) => ViewBook(item: Book),
                )
                .toList(),
          );
        },
      ),
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

  List<Book> _itemList() {
    return [
      Book(
        id: "0",
        name: 'Speak English Level 1',
        description: 'Actions, School & Animals',
        image: 'assets/images/book1.jpg',
      ),
      Book(
        id: "1",
        name: 'Speak English Level 2',
        description: 'Action, Adventure, Sci-Fi',
        image: 'assets/images/book2.jpg',
      ),
      Book(
        id: "2",
        name: 'Speak English Level 3',
        description: 'Action, Adventure, Sci-Fi',
        image: 'assets/images/book3.jpg',
      ),
      Book(
        id: "3",
        name: 'Speak English Level 4',
        description: 'Action, Adventure, Comedy',
        image: 'assets/images/book4.jpg',
      ),
      Book(
        id: "4",
        name: 'Speak English Level 4',
        description: 'Action, Adventure, Comedy',
        image: 'assets/images/book4.jpg',
      ),
      Book(
        id: "5",
        name: 'Speak English Level 4',
        description: 'Action, Adventure, Comedy',
        image: 'assets/images/book4.jpg',
      ),
      Book(
        id: "6",
        name: 'Speak English Level 4',
        description: 'Action, Adventure, Comedy',
        image: 'assets/images/book4.jpg',
      ),
      Book(
        id: "7",
        name: 'Speak English Level 4',
        description: 'Action, Adventure, Comedy',
        image: 'assets/images/book4.jpg',
      ),
    ];
  }
}
