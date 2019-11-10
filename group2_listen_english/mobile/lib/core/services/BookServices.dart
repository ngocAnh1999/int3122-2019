import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/services/StrapiRequest.dart';

class BookServices {
  final Firestore firestore = Firestore.instance;
  final StrapiReq req = new StrapiReq();

  /**
   * Get books from firebase
   */
  Future<List<Book>> getEBooks() async {
    QuerySnapshot result = await firestore.collection('EnglishBook').orderBy('book_id').getDocuments();
    return result.documents.map((snapshot) => Book.fromESnapshot(snapshot)).toList();
  }

  /**
   * Get books from strapi
   */
  Future<List<Book>> getBooks() async {
    final response = await req.request('books', method: 'GET');
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      return result.map((data) => Book.fromMappedJson(data)).toList();
    }
    else
      throw Exception('Unable to get books.');
  }

  /**
   * Post a book to strapi
   */
  Future<Book> postBook(Book book) async {
    print(book.toStrJson());
    final response = await req.request('books',body: book.toStrJson(),method: 'POST');
    if (response.statusCode == 200) {
      return Book.fromMappedJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch book');
    }
  }

  /**
   * Get book with book_id from strapi
   */
  Future<Book> getBook(int book_id) async {
    final response = await req.request('books?book_id=' + book_id.toString(),method: 'GET');
    if (response.statusCode == 200) {
      return Book.fromMappedJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch book');
    }
  }
}