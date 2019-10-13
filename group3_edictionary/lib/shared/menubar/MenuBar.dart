import 'package:flutter/material.dart';
import '../../screens/book/BookList.dart';
import './components/UserGeneralInfo.dart';

class MenuBar extends StatelessWidget{

    MenuBar({ Key key }) : super(key : key);

	@override 
	Widget build(BuildContext context) {
		return Drawer(
			child: ListView(
				padding: EdgeInsets.zero,
				children: <Widget>[
					UserGeneralInfo(),
					ListTile(
						leading: Icon(Icons.book),
						title: Text('Sách'),
						onTap: (){
							print('Pressed Books.');
							Navigator.pop(context);
							Navigator.push(context, MaterialPageRoute(builder: (context) => BookList()));
						},
					),
					ListTile(
						leading: Icon(Icons.account_box),
						title: Text('Tài khoản'),
						onTap : (){
							print('Pressed User.');
							Navigator.pop(context);
             			 	Navigator.push(context, MaterialPageRoute(builder: (context) => BookList()));
						}
					)
				],
			),
		);
	}
}

