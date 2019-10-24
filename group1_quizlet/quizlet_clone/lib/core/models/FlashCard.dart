class FlashCard {
  String word;
  String meaning;
  String id;
  String lessonId;

  FlashCard({this.id, this.lessonId, this.word, this.meaning});

  FlashCard.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    this.lessonId = snapshot['lessonId'];
    this.word = snapshot['word'] ?? '';
    this.meaning = snapshot['meaning'] ?? '';
  }

  toJson() {
    return {'word': word, 'meaning': meaning, 'lessonId': lessonId};
  }
}
