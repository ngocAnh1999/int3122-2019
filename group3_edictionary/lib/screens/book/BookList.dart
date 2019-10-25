import 'package:flutter/material.dart';
import '../../shared/menubar/MenuBar.dart';
import '../unit/UnitList.dart';
import '../../models/Book.dart';
import '../../services/BookServices.dart';

class BookList extends StatefulWidget { 
  String currentUserId;
  
  BookList({ Key key, this.currentUserId}) : super(key : key);

  @override
  BookListState createState() => BookListState();
}

class BookListState extends State<BookList> {
  final BookService _bookService = new BookService();
  List<Book> books = [];
  bool loading = false;

  @override
  void initState(){
    super.initState();
    fetchBooks();
  }

  Future<Null> fetchBooks() async{
    this.setState((){
      loading = true;
    });

    List<Book> fetchedBooks = await _bookService.findBooks();
    print(fetchedBooks);    
    this.setState((){
      books = fetchedBooks;
      loading = false;
    });
  }

	@override 
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title : Text('Home')),
			drawer: MenuBar(),
			body: Stack(
        children : <Widget>[
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
        ]
      )
		);
	}

	Widget _buildRow(context, index) {
		if (index >= books.length) 
			return null;

    Book currentBook = books[index];
		return new ListTile(
			title : Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
						margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
						width: 40.0,
						height: 40.0,
						decoration: new BoxDecoration(
							shape: BoxShape.circle,
							image: DecorationImage(
								fit: BoxFit.fill,
								image: new NetworkImage(currentBook.coverUrl)
							),
							color: Colors.blue
						),
					),
          Expanded(
            child: Text(
              '  ${currentBook.name}',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            )
          )
        ],
      ),
			onTap: () {
				Navigator.push(context, 
					MaterialPageRoute(builder: (context) => UnitList(
						bookId : currentBook.bookId,
						bookTitle : currentBook.name 
					)));
			},
		);
	}
}