import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/core/models/UserSearch.dart';
import 'package:quizlet_clone/core/utilities/FacebookProfileGetter.dart';
import 'package:quizlet_clone/presentation/views/search/UserSearchResultView.dart';

class UserSearchItem extends StatefulWidget {
  final UserSearch user;

  UserSearchItem({@required this.user, Key key}) : super(key: key);

  @override
  _UserSearchItemState createState() => _UserSearchItemState();
}

class _UserSearchItemState extends State<UserSearchItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserSearchResultView(user: widget.user))),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(FacebookProfileGetter.getAvatarUrl(
                        facebookId: widget.user.facebookId)))),
          ),
          title: Text(widget.user.username),
        ),
      ),
    );
  }
}
