class Lesson {
  String id;
  String title;
  String description;
  int numberOfFlashCards;
  String userId;

  Lesson(
      {this.id,
      this.title,
      this.description,
      this.numberOfFlashCards,
      this.userId});

  Lesson.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.title = snapshot['title'] ?? '';
    this.description = snapshot['description'] ?? '';
    this.numberOfFlashCards = snapshot['numberOfFlashCards'];
    this.userId = snapshot['userId'] ?? '';
  }

  toJson() {
    return {
      'title': title,
      'description': description,
      'numberOfFlashCard': numberOfFlashCards,
      'userId': userId
    };
  }
}
