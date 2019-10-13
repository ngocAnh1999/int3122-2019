import 'package:flutter/material.dart';

class WordTile extends StatefulWidget{

	final int wordId;

	WordTile({ Key key, @required this.wordId }) : super(key : key);

	@override
  	WordTileState createState() => new WordTileState();
}

class WordTileState extends State<WordTile> { 

	@override WordTile get widget => super.widget;

	Map pickedMethods = {
		'listenning' : false,
		'speaking' : false,
		'writing' : false,
		'reading' : false
	};

	final String word = 'football';
	final String example = 'They like football.';
	final String meaning = 'Bóng đá';


	@override
	Widget build(BuildContext context) {
		return ListTile(
			title : Column(
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
						new Container(
							margin: EdgeInsets.only(right: 20),
							width: 40.0,
							height: 40.0,
							decoration: new BoxDecoration(
							shape: BoxShape.circle,
							color: Colors.blue  
							),
						),	
						new Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisAlignment: MainAxisAlignment.start,
							children: <Widget>[
							new Row(
								children: <Widget>[
								Text(
									this.word,
									textScaleFactor: 0.95,
									style: TextStyle(color: Colors.red)
								),
								IconButton(
									icon: Icon(Icons.volume_up),
									color: Colors.green,
									onPressed: () => print('Press started music.'),
								),
								Text(this.meaning, textScaleFactor: 0.95)
								],
							),
							Text(this.example, style: TextStyle(fontStyle: FontStyle.italic))
							],
						),
						],
					),
					getCheckBoxes(),
					Divider()

				],
			)

			
		);
	}


	Widget getCheckBoxes() {
		return Row(
			mainAxisAlignment: MainAxisAlignment.end,
			children: <Widget>[
				Theme(
					child: Checkbox(value: pickedMethods['listenning'], tristate: false, onChanged: handleOnChangeCheckbox('listenning')),
					data : ThemeData(unselectedWidgetColor: Colors.yellow[700])
				),
				Theme(
					child: Checkbox(value: pickedMethods['speaking'], tristate: false, onChanged: handleOnChangeCheckbox('speaking')),
					data : ThemeData(unselectedWidgetColor: Colors.blue[700])
				),
				Theme(
					child: Checkbox(value: pickedMethods['reading'], tristate: false, onChanged: handleOnChangeCheckbox('reading')),
					data : ThemeData(unselectedWidgetColor: Colors.green[700])
				),
				Theme(
					child: Checkbox(value: pickedMethods['writing'], tristate: false, onChanged: handleOnChangeCheckbox('writing')),
					data : ThemeData(unselectedWidgetColor: Colors.red[700])
				),
			],
		);
	}

	Function handleOnChangeCheckbox(String methodKey){
		void changeState(value) {
			setState(() {
				pickedMethods[methodKey] = value;
			});
			print('Check $methodKey');
		}

		return changeState;
	}
	

}