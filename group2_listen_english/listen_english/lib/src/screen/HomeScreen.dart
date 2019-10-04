import 'package:flutter/material.dart';
// import 'package:flutter_gridview_app/model/Item.dart';
// import 'package:flutter_gridview_app/screen/ItemList.dart';

// class HomeScreen extends StatelessWidget {
//   List<Item> itemList;

//   @override
//   Widget build(BuildContext context) {
//     itemList = _itemList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movies'),
//       ),
//       body: _gridView(),
//     );
//   }

//   Widget _gridView() {
//     return GridView.count(
//       crossAxisCount: 2,
//       padding: EdgeInsets.all(4.0),
//       childAspectRatio: 8.0 / 9.0,
//       children: itemList
//           .map(
//             (Item) => ItemList(item: Item),
//           )
//           .toList(),
//     );
//   }

//   List<Item> _itemList() {
//     return [
//       Item(
//         id: 0,
//         name: 'Avengers: Infinity War',
//         category: 'Action, Adventure, Fantasy',
//         desc: 'The Avengers and their allies must be willing '
//             'to sacrifice all in an attempt to defeat '
//             'the powerful Thanos before his blitz of '
//             'devastation and ruin puts an end to the universe.'
//             '\nAs the Avengers and their allies have continued '
//             'to protect the world from threats too large for '
//             'any one hero to handle, a danger has emerged '
//             'from the cosmic shadows: Thanos.',
//         rating: 8.7,
//         directors: 'Directors: Anthony Russo, Joe Russo',
//         releaseDate: '27 April 2018',
//         releaseDateDesc: 'USA (2018), 2h 29min',
//         runtime: '2h 29min',
//         bannerUrl: 'assets/images/movie_banner_1.png',
//         imageUrl: 'assets/images/ic_preview_1.png',
//         trailerImg1: 'assets/images/ic_thumb_11.png',
//         trailerImg2: 'assets/images/ic_thumb_12.png',
//         trailerImg3: 'assets/images/ic_thumb_13.png',
//       ),
//       Item(
//         id: 1,
//         name: 'Transformers: The Last Knight',
//         category: 'Action, Adventure, Sci-Fi',
//         desc: 'Autobots and Decepticons are at war, with humans '
//             'on the sidelines. Optimus Prime is gone. The key to '
//             'saving our future lies buried in the secrets of the past, '
//             'in the hidden history of Transformers on Earth.',
//         rating: 5.2,
//         directors: 'Directors: Michael Bay',
//         releaseDate: '21 June 2017',
//         releaseDateDesc: 'USA (2017), 2h 34min',
//         runtime: '2h 34min',
//         bannerUrl: 'assets/images/movie_banner_2.png',
//         imageUrl: 'assets/images/ic_preview_2.png',
//         trailerImg1: 'assets/images/ic_thumb_21.png',
//         trailerImg2: 'assets/images/ic_thumb_21.png',
//         trailerImg3: 'assets/images/ic_thumb_21.png',
//       ),
//       Item(
//         id: 2,
//         name: 'Pacific Rim: Uprising',
//         category: 'Action, Adventure, Sci-Fi',
//         desc: 'Jake Pentecost, son of Stacker Pentecost, reunites with '
//             'Mako Mori to lead a new generation of Jaeger pilots, including '
//             'rival Lambert and 15-year-old hacker Amara, against a new Kaiju threat.',
//         rating: 5.7,
//         directors: 'Directors: Steven S. DeKnight',
//         releaseDate: '23 March 2018',
//         releaseDateDesc: 'USA (2018), 1h 51min',
//         runtime: '1h 51min',
//         bannerUrl: 'assets/images/movie_banner_3.png',
//         imageUrl: 'assets/images/ic_preview_3.png',
//         trailerImg1: 'assets/images/ic_thumb_31.png',
//         trailerImg2: 'assets/images/ic_thumb_31.png',
//         trailerImg3: 'assets/images/ic_thumb_31.png',
//       ),
//       Item(
//         id: 3,
//         name: 'Thor: Ragnarok',
//         category: 'Action, Adventure, Comedy',
//         desc: 'Thor is imprisoned on the planet Sakaar, and must '
//             'race against time to return to Asgard and stop Ragnarök, '
//             'the destruction of his world, at the hands of the powerful '
//             'and ruthless villain Hela.',
//         rating: 7.9,
//         directors: 'Directors: Taika Waititi',
//         releaseDate: '3 November 2017',
//         releaseDateDesc: 'USA (2017), 2h 10min',
//         runtime: '2h 10min',
//         bannerUrl: 'assets/images/movie_banner_4.png',
//         imageUrl: 'assets/images/ic_preview_4.png',
//         trailerImg1: 'assets/images/ic_thumb_41.png',
//         trailerImg2: 'assets/images/ic_thumb_41.png',
//         trailerImg3: 'assets/images/ic_thumb_41.png',
//       ),
//     ];
//   }
// }

class ListViewBook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BookViewState();
  }
}

class BookViewState extends State<ListViewBook> {
  final List<String> books = <String>[
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
    'Book 5',
  ];
  final _checkedSelected = new Set<String>();
  final List<String> fiveBook = <String>[
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
    'Book 5',
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(itemBuilder: (context, index) {
        if (index >= books.length) {
          books.addAll(fiveBook);
        }
        return _buildRow(books[index], index);
      }),
    );
  }

  Widget _buildRow(String bookName, int index) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedSelected.contains(bookName);
    return new 
	Container(
    padding: new EdgeInsets.all(8.0),
	color: Colors.grey,
	margin: EdgeInsets.all(24),
    height: 250.0,
	alignment: Alignment.center,
    // child: new Stack(
    //   children: <Widget>[
 
    //   ],
    // ),
	//   child: Text("Book1"),
  	// constraints: BoxConstraints.expand(),
	);
  }

  Widget _buildRowBook(String bookName, int index) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedSelected.contains(bookName);
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset('assets/images/oxford.jpg'),
        ),
        Expanded(
          child: Image.asset('assets/images/oxford.jpg'),
        ),
      ],
    );
  }

  Widget _buildRowBookImage(String bookName, int index) => Container(
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset('assets/images/oxford.jpg'),
            ),
            Expanded(
              child: Image.asset('assets/images/oxford.jpg'),
            ),
          ],
        ),
      );
}

// Card(
//   child: Column(
//     children: <Widget>[
//       Image.asset('assets/macbook.jpg'),
//       Text(element,
//           style: TextStyle(color: Colors.deepPurple))
//     ],
//   ),
// )

class HomeScreen extends StatelessWidget {
  final String appTitle = 'Listen & Speak English';
  final String drawerTitle = "Nghe noi - Sach cung";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: 'Listen & Speak English'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // body: Center(child: Text('Hello world!')),
      body: ListViewBook(),
      // body: new Image.asset(
      //   'assets/images/oxford.jpg',
      // ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                "Nghe noi - Sach cung",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Sach'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Nguoi dung'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('Ket qua hoc'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Gioi thieu'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
