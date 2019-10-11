import 'package:flutter/material.dart';

class UserGeneralInfo extends StatelessWidget {
	UserGeneralInfo({ Key key }) : super(key : key);

	final String avatarUri = "https://i.imgur.com/BoN9kdC.png";
	final String userEmail = "dung18dv@gmail.com";

	@override 
	Widget build(BuildContext context) {
		return DrawerHeader(
			child : new Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					new Container(
						margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
						width: 75.0,
						height: 75.0,
						decoration: new BoxDecoration(
							shape: BoxShape.circle,
							image: DecorationImage(
								fit: BoxFit.fill,
								image: new NetworkImage(this.avatarUri)
							),
							color: Colors.white
						),
					),
					new Text(
						this.userEmail, 
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