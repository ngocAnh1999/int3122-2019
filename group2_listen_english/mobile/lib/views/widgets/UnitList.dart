import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constant/Constant.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Conversation.dart';
import 'package:mobile/core/models/Unit.dart';
import 'package:mobile/core/services/ConversationServices.dart';
import 'package:mobile/core/services/UnitServices.dart';
import 'package:mobile/views/screen/ChatScreen.dart';

class UnitList extends StatefulWidget {
  final Book book;

  UnitList({Key key, this.book}) : super(key: key);

  @override
  _UnitListState createState() {
    return new _UnitListState();
  }
}

class _UnitListState extends State<UnitList> {
  final UnitServices bookServices = new UnitServices();
  final ConversationServices conversationServices = new ConversationServices();
  List<Unit> listUnit = [];
  bool isLoadingUnit = false;
  bool isLoadingConversation = false;
  @override
  void initState() {
    super.initState();
    fetchUnit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.book.name),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          ListView.builder(
              itemCount: listUnit.length,
              itemBuilder: (context, index) {
                return _buildRow(listUnit[index], index, context);
              }),
          Positioned(
            child: isLoadingUnit
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          ),
        ]));
  }

  Widget _buildRow(Unit unit, int index, BuildContext context) {
    final color = index < 5 ? Colors.red : Colors.blue;
    // print("Check unit name " + unit.name + " with number conversation = " + unit.conversations.length.toString());
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                    book: this.widget.book,
                    unit: unit,
                    conversation: null)),
          );
        },
        child: Container(
            // height: 50,
            padding: EdgeInsets.all(10.0),
            child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Icon(
                              Icons.book,
                              color: color,
                              size: 26,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              unit.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),

                           new Spacer(),
                           Container(
                             padding: EdgeInsets.only(left: 10.0, right: 10.0),
                             child: Icon(Icons.check_box_outline_blank, color: Colors.green)
                           ),
                          Icon(Icons.navigate_next, color: Colors.black),
                        ],
                      ),
                       ListView.builder(
                           itemCount: unit.conversations.length,
                           itemBuilder: (context, index) {
                             return _buildRowConversation(unit.conversations[index], index, context);
                           })
                    ],
              ),
            ))));
  }

  Widget _buildRowConversation(
      Conversation conversation, int index, BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Icon(
            Icons.book,
            color: Colors.blue,
            size: 26,
          ),
        ),
        Expanded(
          child: Text(
            conversation.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        Icon(Icons.navigate_next, color: Colors.black),
      ],
    );
  }

  void fetchUnit() async {
    this.setState(() {
      isLoadingUnit = true;
    });
    listUnit = await this.bookServices.getEUnitOf(widget.book);
    this.setState(() {
      isLoadingUnit = false;
    });
    print("Check length listUnit = " + listUnit.length.toString());
    for (int index = 0; index < listUnit.length; index++) {
      fetchConversationOfUnit(index, listUnit[index]);
    }
  }

  void fetchConversationOfUnit(int indexUnit, Unit unit) async {
    this.setState(() {
      isLoadingConversation = true;
    });
    List<Conversation> tempConversation = await this.conversationServices.getEConversationOf(widget.book, unit);
    listUnit[indexUnit].conversations = tempConversation;
       
    print("Check get success conversation unit index = " + indexUnit.toString() + " with number conversation = " + tempConversation.length.toString());
    this.setState(() {
      isLoadingConversation = false;
    });
  }
}
