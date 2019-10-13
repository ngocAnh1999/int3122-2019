import 'package:flutter/material.dart';
import '../../shared/menubar/MenuBar.dart';
import '../../screens/lession/LessionList.dart';

class BookList extends StatelessWidget {
	final List<String> bookNames = [
		'Tiếng Anh 1 Tập 1',
		'Tiếng Anh 1 Tập 2',
		'Tiếng Anh 2 Tập 1',
		'Tiếng Anh 2 Tập 2',
		'Tiếng Anh 3 Tập 1',
		'Tiếng Anh 3 Tập 2',
		'Tiếng Anh 4 Tập 1',
		'Tiếng Anh 4 Tập 2',
		'Tiếng Anh 5 Tập 1',
		'Tiếng Anh 5 Tập 2',
		'Tiếng Anh 6 Tập 1',
		'Tiếng Anh 6 Tập 2',
		'Tiếng Anh 7 Tập 1',
		'Tiếng Anh 7 Tập 2',
	];

	@override 
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title : Text('Home')),
			drawer: MenuBar(),
			body: Center(
				child: new ListView.builder(
					padding: EdgeInsets.all(10.0),
					itemBuilder: _buildRow
				),
			),
		);
	}

	Widget _buildRow(context, index) {
		if (index >= bookNames.length) 
			return null;
		
		return new ListTile(
			title : Text(bookNames[index]),
			onTap: () {
				print(context);
				Navigator.push(context, 
					MaterialPageRoute(builder: (context) => LessionList(
						bookId : index,
						bookName : 'Book $index'
					)));
			},
		);
	}


}