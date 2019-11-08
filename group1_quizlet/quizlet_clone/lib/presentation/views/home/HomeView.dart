import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/services/LessonService.dart';
import 'package:quizlet_clone/presentation/views/searching/SearchingView.dart';
import 'package:quizlet_clone/presentation/views/user/UserView.dart';

import 'LessonList.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchQuery = new TextEditingController();
  BottomNavigationBar _bottomNavigationBar = null;
  List<Widget> _APPBAR_NAMES = null;
  int _selectedIndex = 0;
  final LessonService lessonService = LessonService.instance;
  final List<dynamic> _widgetOptions = <dynamic>[
    LessonList(),
    SearchingView(),
    Center(child: UserView())
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _bottomNavigationBar = BottomNavigationBar(
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
    );

    _APPBAR_NAMES = [
      AppBar(
        title: Text('Trang chủ'),
      ),
      PreferredSize(
          preferredSize: Size.fromHeight(120.0), // here the desired height
          child: AppBar(
            title: TextField(
              onChanged: (text) {
                // Process find infor
              },
              controller: _searchQuery,
              style: TextStyle(fontSize: 18),
              decoration: new InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: new Icon(Icons.search, color: Colors.black26),
                  hintText: "Tìm kiếm...",
                  hintStyle:
                  new TextStyle(color: Colors.black54, fontSize: 18)),
            ),
            bottom: TabBar(
              labelPadding: const EdgeInsets.only(top: 16),
              labelStyle: TextStyle(
                fontSize: 15,
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 5, color: Color(0xfff1c40f)),
              ),
              tabs: <Widget>[
                Tab(
                  text: "Học phần".toUpperCase(),
                ),
                Tab(text: "Người dùng".toUpperCase())
              ],
            ),
          )),
      AppBar(
        title: Text('Người dùng'),
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_selectedIndex != 1)
        ? Scaffold(
            appBar: _APPBAR_NAMES[_selectedIndex],
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: _bottomNavigationBar,
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _APPBAR_NAMES[_selectedIndex],
              body: SearchingView(),
              bottomNavigationBar: _bottomNavigationBar,
            ));
  }
}
