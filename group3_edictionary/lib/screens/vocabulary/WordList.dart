import 'package:flutter/material.dart';
import './components/WordTile.dart';
import '../../services/WordService.dart';
import '../../models/Word.dart';
import '../learning/LearningScreen.dart';

class WordList extends StatefulWidget { 
  int bookId;
	int unitId;
  String unitName;

	WordList({ Key key, @required this.bookId, @required this.unitId, this.unitName }) : super(key : key);

  @override
  WordListState createState() => WordListState();
}


class WordListState extends State<WordList> {
  final WordService _wordService = WordService();
  
  List<Word> words = [];
  
  bool loading = false;

  @override
  void initState(){
    super.initState();
    fetchWords();
  }

  Future<String> getImageSource(List<Word> words) async {
    String imageName;
    for (Word word in words)
      if (word.imageName != null){
        imageName = word.imageName;
        print(imageName);
        break;
      }
    
    String fetchedImageSource = await _wordService.findSourceFromImageName(imageName);
    return fetchedImageSource;
  }

  Future<Null> fetchWords() async {
    this.setState((){
      loading = true;
    });

    List<Word> fetchedWords = await _wordService.findWords(
      bookId: widget.bookId,
      unitId: widget.unitId
    );  

    String fetchedImageSource = await getImageSource(fetchedWords);
    List<Word> fetchedImageWords = fetchedWords.map((word){
      word.setImageSource(fetchedImageSource);
      return word;
    }).toList();

    this.setState((){
      loading = false;
      words = fetchedImageWords;
    });
  }


	@override 
	Widget build(BuildContext context) {
		return Scaffold(
		  appBar: AppBar(
				title : Text('Unit ${widget.unitId}: ${widget.unitName}'),
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

			body: Stack(
        children : <Widget>[
          Center(
            child: new ListView.builder(
              itemBuilder: _buildRow
            ),
          ),
          loading ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.7,
                child: ModalBarrier(dismissible: false, color : Colors.black),
              ),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ) : Stack()
        ]
      ),
      bottomNavigationBar: _buildLearnPlayBar(context),
		);
	}

  Widget _buildLearnPlayBar(context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]
          )
        )
      ),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child : FlatButton.icon(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LearningScreen(words: words)) 
                );
              },
              icon: Icon(Icons.play_arrow, color : Colors.white),
              color: Colors.blue,
              label: Text('HỌC', style: TextStyle(color: Colors.white)),
            ),
          ),
          
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child : FlatButton.icon(
              onPressed: (){
                print('Yolo');
              },
              icon: Icon(Icons.book, color : Colors.white),
              color: Colors.blue,
              label: Text('CHƠI', style: TextStyle(color: Colors.white)),
            ),
          )
          
        ],
      )
    );
  }
	Widget _buildRow(context, index) {
		if (index >= words.length) 
			return null;
		
		return WordTile(word: words[index]);
	}
}