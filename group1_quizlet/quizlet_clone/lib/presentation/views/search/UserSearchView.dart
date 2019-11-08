import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/services/SearchService.dart';
import 'package:quizlet_clone/presentation/views/search/UserSearchItem.dart';

class UserSearchView extends StatefulWidget {
  final String keyword;

  UserSearchView({@required this.keyword, Key key}) : super(key: key);

  @override
  _UserSearchViewState createState() => _UserSearchViewState();
}

class _UserSearchViewState extends State<UserSearchView> {
  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(
        fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold);
    if (widget.keyword.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text(
                "Bạn muốn tìm giáo viên và bạn học ?",
                style: _textStyle,
              ),
            ),
          ),
          ListTile(
            title: Center(
              child: Text(
                "Hãy nhập tên người dùng Quizlet của họ",
                style: _textStyle,
              ),
            ),
          )
        ],
      );
    }
    return FutureBuilder(
      future: SearchService.searchUser(key: widget.keyword),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            var users = snapshot.data;
            return ListView(
                padding: const EdgeInsets.all(16),
                children: new List<Widget>.from(
                    users.map((u) => UserSearchItem(user: u))));
        }
        return null;
      },
    );
  }
}
