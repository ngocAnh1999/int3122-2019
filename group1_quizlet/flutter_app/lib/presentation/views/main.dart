import 'package:flutter/material.dart';
import 'package:flutter_app/data/api/APIDataSource.dart';
import 'package:flutter_app/data/repository/LessonRepositoryImpl.dart';
import 'package:flutter_app/domain/model/Lesson.dart';
import 'package:flutter_app/domain/model/Vocabulary.dart';
import 'package:flutter_app/domain/usecase/GetLessonsUseCase.dart';
import 'package:flutter_app/presentation/views/home.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

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
  static final GetLessonsUseCase getLessonsUseCase = new GetLessonsUseCase(
      lessonRepository: LessonRepositoryImpl(apiDataSource: APIDataSource()));
  static List<dynamic> _widgetOptions = <dynamic>[
    LessonList(lessons: getLessonsUseCase.excute()),
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
