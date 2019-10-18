import 'package:flutter/material.dart';
import '../book/BookList.dart';
class HomePage extends StatefulWidget { 
  String currentUserId;
  
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return BookList(currentUserId: widget.currentUserId);
  }

}