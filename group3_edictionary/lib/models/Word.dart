import 'package:cloud_firestore/cloud_firestore.dart';

class Word {
  int bookId;
  int unitId;
  String docId;
  String content;
  String imageName;
  String meaning;
  String pronunciation;
  String sentence;
  String type;
  String imageSource;

  Word({
    this.bookId, 
    this.unitId, 
    this.docId, 
    this.content, 
    this.imageName, 
    this.meaning, 
    this.pronunciation, 
    this.sentence, 
    this.type,
    this.imageSource
  });

  factory Word.fromSnapshot(DocumentSnapshot snapshot){
    return new Word(
      bookId: snapshot['book_id'],
      unitId : snapshot['unit_id'],
      docId : snapshot.documentID,
      content : snapshot['content'],
      imageName: snapshot['image_name'],
      meaning : snapshot['meaning'],
      pronunciation: snapshot['pronunciation'],
      sentence: snapshot['sentence'],
      type: snapshot['type'],
    );
  } 

  void setImageSource(String imageSource){
    this.imageSource = imageSource;
  }

}