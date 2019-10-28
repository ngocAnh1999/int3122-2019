class Lesson {
  String id;
  String title;
  String description;
  String userId;

  Lesson(
      {this.id,
      this.title,
      this.description,
      this.userId});

  Lesson.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.title = snapshot['title'] ?? '';
    this.description = snapshot['description'] ?? '';
    this.userId = snapshot['userId'] ?? '';
  }

  toJson() {
    return {
      'title': title,
      'description': description,
      'userId': userId
    };
  }
}
