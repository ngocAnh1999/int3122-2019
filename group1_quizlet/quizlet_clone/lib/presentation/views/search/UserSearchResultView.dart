import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/UserSearch.dart';
import 'package:quizlet_clone/core/services/LessonService.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';
import 'package:quizlet_clone/presentation/views/home/LessonItem.dart';

class UserSearchResultView extends StatefulWidget {
  final UserSearch user;

  UserSearchResultView({@required this.user, Key key}) : super(key: key);

  @override
  _UserSearchResultViewState createState() => _UserSearchResultViewState();
}

class _UserSearchResultViewState extends State<UserSearchResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thông tin người dùng'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.lightBlue, width: 2),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  FacebookProfileGetter.getAvatarUrl(
                                      facebookId: widget.user.facebookId)))),
                    ),
                    Center(
                      child: Text(widget.user.username,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
            ),
            FutureBuilder(
              future: LessonService.instance
                  .getLessonsByUser(username: widget.user.username),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case ConnectionState.done:
                    var lessons = snapshot.data;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: new List<Widget>.from(
                              lessons.map((l) => LessonItem(lesson: l))),
                        ),
                      ),
                    );
                }
                return null;
              },
            )
          ],
        ));
  }
}
