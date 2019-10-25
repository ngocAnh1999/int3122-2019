import 'package:flutter/material.dart';
import '../../../models/Word.dart';
import '../../../helpers/Speaker.dart';

class WordTile extends StatefulWidget{

	Word word;

	WordTile({ Key key, @required this.word }) : super(key : key);

	@override
  	WordTileState createState() => new WordTileState();
}

class WordTileState extends State<WordTile> { 
  Speaker _speaker = new Speaker();
  Word get word => widget.word;

  Map pickedMethods = {
    'listenning' : true,
    'writing' : true,
    'reading' : true,
    'speaking' : true
  };
  
	@override
	Widget build(BuildContext context) {
		return ListTile(
			title : Column(
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(word.imageSource)
                  ),
                  color: Colors.blue
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start ,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        word.content,
                        textScaleFactor: 0.95,
                        style: TextStyle(color: Colors.red)
                      ),
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        color: Colors.green,
                        onPressed: _handleOnContentPressPlay(word.content),
                      ),
                    ],
                  ),
                  Text(word.meaning,
                    textScaleFactor: 0.95,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Text(word.sentence, style: TextStyle(fontStyle: FontStyle.italic))
                ],
						  ),
						],
					),
					// getCheckBoxes(),
					Divider()

				],
			),
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

  Function _handleOnContentPressPlay(content){
    Future<Null> _handlePlay() async {
      return await _speaker.speak(content);
    }

    return _handlePlay;
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