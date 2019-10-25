import 'package:flutter/material.dart';
import '../vocabulary/WordList.dart';
import '../../services/UnitService.dart';
import '../../models/Unit.dart';

class UnitList extends StatefulWidget {

  int bookId;
  String bookTitle;

  UnitList({ Key key, this.bookId, this.bookTitle}) : super(key : key);

  @override
  UnitListState createState() => new UnitListState();
}


class UnitListState extends State<UnitList> {
  final UnitService _unitService = new UnitService();

  List<Unit> units = [];
  bool loading = false;

  @override
  void initState(){
    super.initState();
    fetchUnits();
  }

  Future<Null> fetchUnits()async{
    this.setState((){
      loading = true;
    });

    List<Unit> fetchedUnits = await _unitService.findUnitsByBookId(widget.bookId);
    
    this.setState((){
      loading = false;
      units = fetchedUnits;
    });
  }

	@override 
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title : Text(widget.bookTitle),
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
        children: <Widget>[
          Center(
            child: new ListView.builder(
              padding: EdgeInsets.all(10.0),
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
        ],
      ) 
      
		);
	}

	Widget _buildRow(context, index) {
		if (index >= units.length) 
			return null;

    Unit currentUnit = units[index];
		
    return new ListTile(
			title : Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Unit ${currentUnit.unitNumber} ', style: TextStyle(color: Colors.blue)),
          Expanded(
            child: Text(
              currentUnit.name, 
              overflow: TextOverflow.fade, 
              maxLines: 1,
              softWrap: false,
            )
          )
        ],
      ),
			onTap: () {
        Navigator.push(context, 
					MaterialPageRoute(builder: (context) => WordList(
						unitId: currentUnit.unitNumber,
            bookId: currentUnit.bookId,
            unitName: currentUnit.name,
					)));
			},
		);
	}
}