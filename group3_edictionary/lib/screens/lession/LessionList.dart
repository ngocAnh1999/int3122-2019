import 'package:flutter/material.dart';
import '../vocabulary/WordList.dart';

class LessionList extends StatelessWidget {

	final int bookId;
	final String bookName;
	final List<String> lessions = [
		'Lession 1',
		'Lession 2',
		'Lession 3',
		'Lession 4'
	];

	LessionList({ Key key, @required this.bookId, @required this.bookName }) : super(key : key);

	@override 
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title : Text(this.bookName),
				leading: IconButton(
					icon : Icon(
						Icons.arrow_back,
						color: Colors.white,
					),
					onPressed: (){
						Navigator.maybePop(context);
					}
				),
				automaticallyImplyLeading: true,
			),
			body: Center(
				child: new ListView.builder(
					padding: EdgeInsets.all(10.0),
					itemBuilder: _buildRow
				),
			),
		);
	}

	Widget _buildRow(context, index) {
		if (index >= lessions.length) 
			return null;

    int count = index+1;

		return new ListTile(
			title : Row(
        
        children: <Widget>[
          Text('Unit $count ', style: TextStyle(color: Colors.blue)),
          Text(lessions[index])
        ],
      ),
			onTap: () {
        Navigator.push(context, 
					MaterialPageRoute(builder: (context) => WordList(
						lessionId : index,
            lessionName: lessions[index]
					)));
			},
		);
	}
}