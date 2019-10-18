import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/services/lessonService.dart';
import 'package:quizlet_clone/presentation/views/HomeController.dart';
void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Quizlet';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static final LessonService lessonService = new LessonService();
  //static final FlashCardService flashCardService = new FlashCardService();
  static List<dynamic> _widgetOptions = <dynamic>[
    LessonList(lessons: lessonService.getLessons()),
    Center(
      child: Text("Đây là màn hình tìm kiếm"),
    ),
    Center(
      child: Text("Đây là màn hình chỉnh sửa"),
    ),
    Center(
      child: Text("Đây là màn hình người dùng"),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Trang chủ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Tìm kiếm'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Chỉnh sửa'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Người dùng'))
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
