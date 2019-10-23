class Lesson {
  String id;
  String title;
  String description;
  int numberOfFlashCards;

  Lesson({this.id, this.title, this.description, this.numberOfFlashCards});

  Lesson.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.title = snapshot['title'] ?? '';
    this.description = snapshot['description'] ?? '';
    this.numberOfFlashCards = snapshot['numberOfFlashCards'];
  }

  toJson() {
    return {
      'title': title,
      'description': description,
      'numberOfFlashCard': numberOfFlashCards
    };
  }
}
