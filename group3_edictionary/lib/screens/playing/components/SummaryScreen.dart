import '../../../models/GameplayState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Consumer<GameplayState>(
      builder: (context, gameplayState, child){
        if (gameplayState.finished == false)
          return Container();

        return Stack(
          children : <Widget>[
            Opacity(
              opacity: 0.7,
              child: ModalBarrier(dismissible: false, color : Colors.black),
            ), 
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left : MediaQuery.of(context).size.width * 0.15,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height : MediaQuery.of(context).size.height * 0.5,
                color: Colors.blue[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text('YOUR RESULT', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('${gameplayState.rightAnswer}', 
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.green)
                        ),
                        Text('/', 
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)
                        ),
                        Text('${gameplayState.wrongAnswer}', 
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.red)
                        ),
                      ],
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.home, color: Colors.white,),
                      label: Text('TRỞ VỀ', style: TextStyle(color: Colors.white)),
                      onPressed: (){
                        Navigator.maybePop(context);
                      },
                      color: Colors.red[300],
                    )
                  ],
                )
              ),
            )
          ]
        );
      }
    );
  }

}