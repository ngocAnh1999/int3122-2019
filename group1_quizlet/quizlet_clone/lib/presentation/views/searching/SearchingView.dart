import 'package:flutter/material.dart';

class SearchingView extends StatefulWidget {
  @override
  SearchingViewState createState() => new SearchingViewState();
}

class SearchingViewState extends State<SearchingView> {
  final _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.black54,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Center(
                child: Text("Nhập một chủ đề hoặc từ khoá", style: _textStyle,),
              )
            ),
            ListTile(
              title: Center(
                child: Text("Mẹo: Càng cụ thể càng tốt", style: _textStyle,),
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Center(
                child: Text("Bạn muốn tìm giáo viên và bạn học ?", style: _textStyle,),
              ),
            ),
            ListTile(
              title: Center(
                child: Text("Hãy nhập tên người dùng Quizlet của họ", style: _textStyle,),
              ),
            )
          ],
        )
      ],
    );
  }
}
