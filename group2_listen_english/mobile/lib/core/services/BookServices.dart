import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/services/StrapiRequest.dart';

class BookServices {
  final Firestore firestore = Firestore.instance;
  final StrapiReq req = new StrapiReq();

  Future<List<Book>> getEBooks() async {
    QuerySnapshot result = await firestore.collection('EnglishBook').orderBy('book_id').getDocuments();
    return result.documents.map((snapshot) => Book.fromESnapshot(snapshot)).toList();
  }

  Future<List<Book>> getBooks() async {
    final response = await req.request('books', method: 'GET');
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      return result.map((data) => Book.fromMappedJson(data)).toList();
    }
    else
      throw Exception('Unable to get books.');
  }

  Future<Book> postBook(Book book) async {

    Map<String,dynamic> data = {
      "book_id": 100,
      "name": "Home"
    };
    final response = await req.request('books',body: data,method: 'POST');
    if (response.statusCode == 200) {
      return Book.fromMappedJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch book');
    }


  }

//  Future<Book> getBook(int book_id) async {
//    final response = await req.request('books',body: book.toStrJson(),method: 'POST');
//    if (response.statusCode == 200) {
//      return Book.fromMappedJson(json.decode(response.body));
//    } else {
//      throw Exception('Unable to fetch book');
//    }
//  }
}