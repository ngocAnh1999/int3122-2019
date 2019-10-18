import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/User.dart';


class UserGeneralInfo extends StatefulWidget{
  UserGeneralInfo({Key key}) : super(key : key);

  UserGeneralInfoState createState() => UserGeneralInfoState();
}

class UserGeneralInfoState extends State<UserGeneralInfo> {
  User currentUser = new User(email: '', avatarUrl: '', name : '');

  @override
  void initState(){
    super.initState();
    fetchUserFromPreferences();
  }

  Future<Null> fetchUserFromPreferences() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String name = await preferences.getString('name');
    String email = await preferences.getString('email');
    String avatarUrl = await preferences.getString('avatar_url');
    String gid = await preferences.getString('gid');

    this.setState((){
      currentUser = new User(name: name, email: email, avatarUrl: avatarUrl, ggId: gid);
    });
  }

	@override 
	Widget build(BuildContext context) {
		return DrawerHeader(
			child : new Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Container(
						margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
						width: 75.0,
						height: 75.0,
						decoration: new BoxDecoration(
							shape: BoxShape.circle,
							image: DecorationImage(
								fit: BoxFit.fill,
								image: new NetworkImage(currentUser.avatarUrl)
							),
							color: Colors.white
						),
					),
					Text(
						'${currentUser.name}', 
						textScaleFactor: 0.9,
						style: TextStyle(color: Colors.white),	
					),
				],
			),
			decoration: BoxDecoration(
				color: Colors.blue
			),
		);
	}
}