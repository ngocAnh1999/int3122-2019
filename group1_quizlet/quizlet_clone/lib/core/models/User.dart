class User {
  String id;
  String facebookId;
  String firstName;
  String lastName;
  String username;
  String email;

  User(
      {this.facebookId,
      this.firstName,
      this.lastName,
      this.email,
      this.username});

  User.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.facebookId = snapshot['facebookId'] ?? '';
    this.firstName = snapshot['firstName'] ?? '';
    this.lastName = snapshot['lastName'] ?? '';
    this.email = snapshot['email'] ?? '';
    this.username = snapshot['username'] ?? '';
  }

  toJson() => {
        'facebookId': facebookId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'username': username
      };
}
