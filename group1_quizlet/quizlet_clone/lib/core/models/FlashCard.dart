class FlashCard {
  String word;
  String meaning;
  String id;
  String lessonId;
  String imageUrl;

  FlashCard({this.id, this.lessonId, this.word, this.meaning});

  FlashCard.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.lessonId = snapshot['lessonId'] ?? '';
    this.word = snapshot['word'] ?? '';
    this.meaning = snapshot['meaning'] ?? '';
    if(snapshot['image'] != null) {
      imageUrl = snapshot['image']['url'];
    }
  }

  toJson() {
    return {'word': word, 'meaning': meaning, 'lessonId': lessonId};
  }
}
