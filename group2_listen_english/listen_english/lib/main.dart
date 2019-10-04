import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class ListViewBook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BookViewState();
  }
}

class BookViewState extends State<ListViewBook> {
  final List<String> books = <String>[
    'A',
    'B',
    'C',
    'D',
  ];
  final _checkedSelected = new Set<String>();
  final List<String> fiveBook = <String>[
    'A',
    'B',
    'C',
    'D',
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
    return new ListTile(
      leading: new Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: color,
      ),
      title: new Text(bookName,
          style: new TextStyle(fontSize: 18.0, color: color)),
      onTap: () {
        setState(() {
          if (isChecked) {
            _checkedSelected.remove(bookName);
          } else {
            _checkedSelected.add(bookName);
          }
        });
      },
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

class MyApp extends StatelessWidget {
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
