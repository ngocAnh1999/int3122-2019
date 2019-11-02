import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
  bool _isPushNotification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
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
                          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cq5dam-web-1200-675-1552905198.jpeg?crop=0.5625xw:1xh;center,top&resize=980:*',
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
                  title: Text("Tên",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  trailing: Text(
                    "Pham Ngoc Tai",
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
                    "taipham1803@gmail.com",
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
                  title: Text("Hiện thông báo",
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
}
