import 'package:flutter/material.dart';
import '../../../models/Word.dart';
import '../../../helpers/RandomHelper.dart';
import '../../../helpers/Speaker.dart';

class ListeningGame extends StatefulWidget{
  List<Word> words;
  int currentIndex;
  PageController pageController;
  ListeningGame({ Key key, this.words, this.currentIndex, this.pageController}) : super(key : key);

  @override 
  ListeningGameState createState() => ListeningGameState();
}

class ListeningGameState extends State<ListeningGame>{
  List<Word> questions = [];
  Word correctAnswer;
  Word userAnswer;
  RandomHelper _randomHelper = new RandomHelper();
  Speaker _speaker = new Speaker();
  List<Word> get words => widget.words;
  bool submitted = false;

  @override
  void initState(){
    super.initState();
    List<Word> fetchedQuestions = _randomHelper.generateQuestions(
      answerIndex: widget.currentIndex,
      source: words,
      numberOfQuestion: 4
    );
    fetchedQuestions.shuffle();
    this.setState((){
      questions = fetchedQuestions;
      correctAnswer = words[widget.currentIndex];
    });
  }

  @override 
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var appBar = new AppBar();

    return Stack(
      children : <Widget>[
        Container(
          height: screenHeight - appBar.preferredSize.height,
          width: screenWidth,
          decoration: BoxDecoration(color:  Colors.red[100]),
          padding: EdgeInsets.fromLTRB(0, 0 , 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            
              IconButton(
                icon: Icon(Icons.volume_up),
                color: Colors.black,
                iconSize: 60,
                onPressed: _handleOnContentPressPlay(correctAnswer.content),
                highlightColor: Colors.white,
                splashColor: Colors.white,
              ),
              _buildAnswers(context),
              
            ],

          ),
        ),
        _buildNavBar(context)
      ]
    );  
  }

  Function _handleOnContentPressPlay(content){
    Future<Null> _handlePlay() async {
      return await _speaker.speak(content);
    }

    return _handlePlay;
  }
  Widget _buildNavBar(context){
    Widget navButton;
    if (submitted == false) 
      navButton = FlatButton(
        child: Text('CHÔT', style: TextStyle(color: Colors.white),),
        color: Colors.green,
        onPressed: (){
          if (userAnswer == null)
            return;
          this.setState((){
            submitted = true;
          });
        },
      );
    else 
      navButton = FlatButton(
        child: Text('TIẾP', style: TextStyle(color: Colors.white),),
        color: Colors.blue,
        onPressed: (){
          print('Next');
          widget.pageController.nextPage(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn
          );
        },
      );
    
    Widget markIcon;
    if (submitted){
      if (userAnswer.content == correctAnswer.content)
        markIcon = new Icon(
          Icons.check,
          color: Colors.green,
        );
      else 
        markIcon = new Icon(
          Icons.close,
          color : Colors.red
        );
    } 
    else 
      markIcon = new Container();
    return Positioned(
      bottom: 20,
      right: 20,
      left : MediaQuery.of(context).size.width * 0.6,
      child: Row(
        children: <Widget>[
          markIcon,
          navButton
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    ); 
    
  }


  Widget _buildAnswers(context){
    // return Text('lalala');
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
      child: Column(
        children: questions.map((Word question){
          Color buttonColor = Colors.white;
          if (userAnswer != null && question.content == userAnswer.content)
            buttonColor = Colors.red;
          if (submitted && question.content == correctAnswer.content) 
            buttonColor = Colors.green;

          return Container( 
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: MediaQuery.of(context).size.width * 0.6,
            child : FlatButton(
              child: Text(question.content, style: TextStyle(color: Colors.black)),
              color: buttonColor,
              onPressed: (){
                if (submitted)
                  return null;
                this.setState((){
                  userAnswer = question;
                });
              },
            )
          );
        }).toList()
      ),
    );
  }
}