import 'package:flutter/cupertino.dart';

class UserSearchView extends StatefulWidget {
  final String keyword;

  UserSearchView({@required this.keyword, Key key}) : super(key: key);

  @override
  _UserSearchViewState createState() => _UserSearchViewState();
}

class _UserSearchViewState extends State<UserSearchView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.keyword));
  }
}
