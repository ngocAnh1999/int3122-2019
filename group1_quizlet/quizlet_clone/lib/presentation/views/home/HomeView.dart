import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/user.dart';
import 'package:quizlet_clone/core/repositories/implementations/lessonRepositoryImpl.dart';
import 'package:quizlet_clone/core/services/lessonService.dart';
import 'package:quizlet_clone/presentation/views/user/UserView.dart';

import 'LessonList.dart';

class HomeView extends StatefulWidget {
  final User currentUser;
  HomeView({Key key, @required this.currentUser}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const _TAB_NAMES = ['Trang chủ', 'Tìm kiếm', 'Chỉnh sửa', 'Người dùng'];
  int _selectedIndex = 0;

  static final LessonService lessonService =
      new LessonService(repository: new LessonRepositoryImpl());
  final List<dynamic> _widgetOptions = <dynamic>[
    LessonList(lessons: lessonService.getLessons()),
    Center(
      child: Text("Đây là màn hình tìm kiếm"),
    ),
    Center(
      child: Text("Đây là màn hình chỉnh sửa"),
    ),
    Center(
      child: UserView()
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
        title: Text(_TAB_NAMES[_selectedIndex]),
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
