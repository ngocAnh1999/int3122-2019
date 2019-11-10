import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/components/ViewBook.dart';
import 'package:mobile/core/constant/Constant.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/services/BookServices.dart';

class BookList extends StatefulWidget {

  @override
  _BookList createState() {
    return new _BookList();
  }
}

class _BookList extends State<BookList> {
  final BookServices bookServices = new BookServices();
  List<Book> listBook = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GridView.count (
            crossAxisCount: 2,
            padding: EdgeInsets.all(4.0),
            childAspectRatio: 7.2 / 12.0,
            children: listBook.map((book) => ViewBook(item: book)).toList(),
          ),
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
    );
  }

  void fetchBook() async{
    this.setState((){
      loading = true;
    });
    listBook = await this.bookServices.getBooks();
    this.setState((){
      loading = false;
    });
  }

}