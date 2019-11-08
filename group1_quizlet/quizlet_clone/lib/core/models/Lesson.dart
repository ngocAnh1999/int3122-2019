class Lesson {
  String id;
  String title;
  String description;
  String username;
  String facebookId;

  Lesson({this.id, this.title, this.description});

  Lesson.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.title = snapshot['title'] ?? '';
    this.description = snapshot['description'] ?? '';
    this.username = snapshot['firebaseuser']['username'] ?? '';
    this.facebookId = snapshot['firebaseuser']['facebookId'] ?? '';
  }

  toJson() {
    return {'title': title, 'description': description};
  }
}
