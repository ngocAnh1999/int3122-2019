class UserSearch {
  String username;
  String facebookId;

  UserSearch({this.username, this.facebookId});

  UserSearch.fromJson(Map snapshot) {
    this.username = snapshot['username'];
    this.facebookId = snapshot['facebookId'];
  }
}
