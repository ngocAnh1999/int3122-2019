import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/models/User.dart';
import 'package:mobile/core/services/authentication.dart';

class UserProfileScreen extends StatefulWidget {

  final BaseAuth auth;

  const UserProfileScreen({Key key, this.auth}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
  bool _isPushNotification = false;
  bool isLoading = false;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User's Profile"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 160.0,
                child: Card(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(50.0),
                        child: Image.network(
                          'http://www.gravatar.com/avatar/?d=mm',
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 22.0,
                  ),
                  title: Text("Name",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  trailing: Text(
                    user.email,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  onTap: () {},
                ),
              ),
              Divider(
                height: 5,
                color: Colors.grey,
                indent: 16,
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 22.0,
                  ),
                  title: Text("Email",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  trailing: Text(
                    user.email,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  onTap: () {},
                ),
              ),
              Divider(
                height: 5,
                color: Colors.grey,
                indent: 16,
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 22.0,
                  ),
                  title: Text("Notification",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  trailing: Switch(
                    onChanged: (val) => setState(
                        () => _isPushNotification = val),
                    value: _isPushNotification,
                    activeColor: Colors.green,
                  ),
                  onTap: (){
                    setState(() {
                      _isPushNotification = !_isPushNotification;
                    });
                  },
                ),
              ),
              Divider(
                height: 5,
                color: Colors.grey,
                indent: 16,
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: Icon(
                    Icons.contact_phone,
                    color: Colors.blue,
                    size: 22.0,
                  ),
                  title: Text("Facebook",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  trailing: Text(
                    "Kết nối tài khoản",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  onTap: () {},
                ),
              ),
              Divider(
                height: 5,
                color: Colors.grey,
                indent: 16,
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  leading: Icon(
                    Icons.contact_phone,
                    color: Colors.blue,
                    size: 22.0,
                  ),
                  title: Text("Google",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  trailing: Text(
                    "Kết nối tài khoản",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  onTap: () {},
                ),
              ),
              Divider(
                height: 5,
                color: Colors.grey,
                indent: 16,
              ),
            ],
          ),
        ));
  }

  void getUser() async {
    this.setState(() {
      isLoading = true;
    });
    FirebaseUser tempUser = await widget.auth.getCurrentUser();
    this.setState(() {
      user = tempUser;
      isLoading = false;
    });
  }
}
