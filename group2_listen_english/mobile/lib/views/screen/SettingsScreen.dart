import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('EnglishBook').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              
            }
          },
        ));
  }
}
