import 'package:cloud_firestore/cloud_firestore.dart';

class Word {
  int bookId;
  int unitId;
  dynamic docId;
  String content;
  String imageName;
  String meaning;
  String pronunciation;
  String sentence;
  String type;

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


  factory Word.fromJson(Map<String, dynamic> data){
    return new Word(
      bookId: data['book_id'],
      unitId : data['unit_id'],
      docId : data['id'],
      content : data['content'],
      imageName: data['image_name'],
      meaning : data['meaning'],
      pronunciation: data['pronunciation'],
      sentence: data['sentence'],
      type: data['type'],
    );
  } 
}