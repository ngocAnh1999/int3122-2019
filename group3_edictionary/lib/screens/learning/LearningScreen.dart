import 'package:flutter/material.dart';
import '../../models/Word.dart';
import '../../helpers/Speaker.dart';

class LearningScreen extends StatefulWidget {
  List<Word> words;
  LearningScreen({Key key, this.words}) : super(key : key);

  @override
  LearningScreenState createState() => LearningScreenState();
}

class LearningScreenState extends State<LearningScreen> {
  Speaker _speaker = new Speaker();
  int _currentPage = 0;

  List<Word> get words => widget.words;

  @override 
  Widget build(BuildContext context){ 
    var appBar = AppBar(
      backgroundColor: Colors.blue[200],
      title: Text('HỌC'),
      leading: IconButton(
        icon : Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.maybePop(context);
        }
      ),
      automaticallyImplyLeading: true,
    );

    return Scaffold(
      appBar: appBar,
      body: PageView.builder(
        itemBuilder: _buildPageItem,
        itemCount : words.length,
        onPageChanged: (int page){
          this.setState((){
            _currentPage = page;
          });
        },
        scrollDirection: Axis.horizontal,
      ),
      floatingActionButton: _currentPage < words.length - 1 ? null : FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
        onPressed: (){
          Navigator.maybePop(context);
        },
      )
    );
  }

  // Widget _buildBottomNav(BuildContext){
  //   return Container(
  //     width: ,
  //   );
  // }

  Widget _buildPageItem(BuildContext context, int position){
    Word currentWord = words[position];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var appBar = new AppBar();

    return Container(
      height: screenHeight - appBar.preferredSize.height,
      width: screenWidth,
      decoration: BoxDecoration(color:  Colors.blue[100]),
      padding: EdgeInsets.fromLTRB(0, screenHeight * 0.15 , 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: screenHeight * 0.25,
            height: screenHeight * 0.25,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0)
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(currentWord.imageSource)
              )
            ),
          ),
          Text(
            currentWord.content,
            style: TextStyle(color: Colors.red[600], fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.volume_up),
            color: Colors.black,
            onPressed: _handleOnContentPressPlay(currentWord.content),
            highlightColor: Colors.white,
            splashColor: Colors.white,
          ),
          Text(
            '''${currentWord.meaning}''',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue[700], fontSize: 16, fontWeight: FontWeight.bold),
          ),
          
          currentWord.sentence != null ? 
          Container(
            child : Text(
              '''${currentWord.sentence}''',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            margin: EdgeInsets.only(top: 10),
          ): null,
        ],

      ),
    );
  }

  Function _handleOnContentPressPlay(content){
    Future<Null> _handlePlay() async {
      return await _speaker.speak(content);
    }

    return _handlePlay;
  }
}