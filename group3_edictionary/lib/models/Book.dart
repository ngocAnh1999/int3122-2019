import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String docId;
  int bookId;
  String coverUrl;
  String imgName;
  String name;
  int totalWords;

  Book({this.docId, this.bookId, this.coverUrl, this.imgName, this.name, this.totalWords});

  factory Book.fromSnapshot(DocumentSnapshot snapshot){
    print(snapshot);
    return Book(
      docId : snapshot.documentID,
      bookId : snapshot.data['book_id'],
      coverUrl: snapshot.data['cover_url'],
      imgName: snapshot.data['img_name'],
      name:  snapshot.data['name'],
      totalWords: snapshot.data['totalWords']
    );
  }
}