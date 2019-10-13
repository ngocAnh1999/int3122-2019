import 'package:flutter/material.dart';
import './components/WordTile.dart';

class WordList extends StatelessWidget {

	final int lessionId;
	final String lessionName;
	final int wordListSize = 10;
	WordList({ Key key, @required this.lessionId, @required this.lessionName }) : super(key : key);

	@override 
	Widget build(BuildContext context) {
		return Scaffold(
		  appBar: AppBar(
				title : Text(this.lessionName),
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
					itemBuilder: _buildRow
				),
			),
		);
	}

	Widget _buildRow(context, index) {
		if (index >= wordListSize) 
			return null;
		
		return WordTile(wordId: index);
	}
}