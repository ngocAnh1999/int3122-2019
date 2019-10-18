import 'package:flutter/material.dart';
import './screens/login-page/LoginPage.dart';
import './screens/home/HomePage.dart';
import './screens/book/BookList.dart';
import 'package:overlay_support/overlay_support.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child : MaterialApp(
        title: 'eDictionary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/login" : (context) => LoginPage(),
          "/home" : (context) => HomePage(),
          "/books" : (context) => BookList()        
        },
        home: LoginPage(),
      )
    );
  }
}
