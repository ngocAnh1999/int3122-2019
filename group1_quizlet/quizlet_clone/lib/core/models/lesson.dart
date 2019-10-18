
class Lesson {
  String id;
  String title;
  String description;

  Lesson({this.id, this.title, this.description});

  Lesson.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.title = snapshot['title'] ?? '';
    this.description = snapshot['description'] ?? '';
  }

  toJson() {
    return {
      'title': title,
      'description': description
    };
  }
}
