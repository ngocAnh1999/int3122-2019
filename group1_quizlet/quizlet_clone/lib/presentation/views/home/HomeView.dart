import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/services/LessonService.dart';
import 'package:quizlet_clone/presentation/views/search/LessonSearchView.dart';
import 'package:quizlet_clone/presentation/views/search/UserSearchView.dart';
import 'package:quizlet_clone/presentation/views/user/UserView.dart';

import 'LessonList.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const _TAB_NAMES = ['Trang chủ', 'Tìm kiếm', 'Người dùng'];
  int _selectedIndex = 0;

  static final LessonService lessonService = LessonService.instance;
  final List<dynamic> _widgetOptions = <dynamic>[
    LessonList(),
    Center(child: Text('search view')),
    Center(child: UserView())
  ];

  final TextEditingController _searchTextField = new TextEditingController();
  String _searchValue = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onInputSearchComplete() {
    setState(() {
      _searchValue = _searchTextField.value.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: (_selectedIndex != 1)
              ? Text(_TAB_NAMES[_selectedIndex])
              : TextField(
                  onEditingComplete: _onInputSearchComplete,
                  controller: _searchTextField,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: new Icon(Icons.search, color: Colors.black26),
                      hintText: 'Tìm kiếm...',
                      hintStyle:
                          new TextStyle(color: Colors.black54, fontSize: 18)),
                ),
          bottom: (_selectedIndex == 1)
              ? TabBar(tabs: [Tab(text: 'Học phần'), Tab(text: 'Người dùng')])
              : null,
        ),
        body: (_selectedIndex != 1)
            ? Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              )
            : TabBarView(
                children: <Widget>[
                  LessonSearchView(keyword: _searchValue),
                  UserSearchView(keyword: _searchValue)
                ],
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
                icon: Icon(Icons.person), title: Text('Người dùng'))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.greenAccent,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
