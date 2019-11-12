// import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Book.dart';
import '../helpers/RequestHelper.dart';
import 'dart:convert';

class BookService {

  final RequestHelper _requestHelper = RequestHelper();

  Future<List<Book>> findBooks() async {
    final response = await _requestHelper.request('books?_sort=book_id:ASC', method: 'GET');
    if (response.statusCode == 200){
      List<dynamic> result = json.decode(response.body);
      return result.map((data) => Book.fromJson(data)).toList();
    } 
    else throw Exception('Unable to fetch books.');
  }

  
}