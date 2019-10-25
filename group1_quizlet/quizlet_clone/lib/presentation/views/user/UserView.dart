import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/User.dart';
import 'package:quizlet_clone/core/services/AuthService.dart';
import 'package:quizlet_clone/core/services/UserService.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';
import 'package:quizlet_clone/presentation/views/login/LoginView.dart';

import 'AboutView.dart';

class UserView extends StatefulWidget {
  @override
  UserViewState createState() => UserViewState();
}

class UserViewState extends State<UserView> {
  void _signOut() async {
    //print("Good bye");
    await AuthService.instance.firebaseLogOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }

  void _showProductInfo() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AboutView()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.instance.getCurrentUser(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            User user = snapshot.data;
            final TextStyle titleStyle =
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
            final TextStyle subtitleStyle =
                TextStyle(fontSize: 14, color: Colors.cyan);
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.lightBlue, width: 2),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        FacebookProfileGetter.getAvatarUrl(
                                            facebookId: user.facebookId)))),
                          ),
                          Center(
                            child: Text(user.username,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 5),
                  Container(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Email', style: titleStyle),
                          subtitle: Text(user.email, style: subtitleStyle),
                        ),
                        ListTile(
                          title: Text('Tên người dùng', style: titleStyle),
                          subtitle: Text(user.username, style: subtitleStyle),
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 5),
                  Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: GestureDetector(
                              child:
                                  Text('Thông tin sản phẩm', style: titleStyle),
                              onTap: _showProductInfo),
                        ),
                        ListTile(
                          title: Text('Phiên bản', style: titleStyle),
                          subtitle: Text('0.0.1', style: subtitleStyle),
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 5),
                  ListTile(
                      title: GestureDetector(
                          child: Text('Đăng xuất',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan)),
                          onTap: _signOut)),
                  Divider(thickness: 5)
                ],
              ),
            );
        }
        return null;
      },
    );
  }
}
