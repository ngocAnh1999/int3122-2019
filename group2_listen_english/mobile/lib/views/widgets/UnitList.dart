import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constant/Constant.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Unit.dart';
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
  List<Unit> listUnit = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    fetchUnit();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text(this.widget.book.name),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ListView.builder(itemCount: listUnit.length,itemBuilder: (context, index){
              return _buildRow(listUnit[index], index, context);
            }),
            Positioned(
              child: loading
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
          ]
        )
      );

  }

  Widget _buildRow(Unit unit, int index, BuildContext context) {
    final color = index < 5 ? Colors.red : Colors.blue;
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(
                  Icons.book,
                  color: color,
                  size: 26,
                ),
              ),
              Text(
                unit.name,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              new Spacer(),
              // Container(
              //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //   child: Icon(Icons.check_box_outline_blank, color: Colors.green)
              // ),
              Icon(Icons.navigate_next, color: Colors.black),
            ],
          ),
        ));
  }

  void fetchUnit() async{
    this.setState((){
      loading = true;
    });
    listUnit = await this.bookServices.getEUnitOf(widget.book);
    this.setState((){
      loading = false;
    });
  }

}