import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Word.dart';
import '../helpers/RequestHelper.dart';
import 'dart:convert';

class WordService{
  
  final RequestHelper _requestHelper = RequestHelper();

  Future<List<Word>> findWords({int bookId, int unitId}) async {
   final response = await _requestHelper.request('words?unit_id=$unitId&book_id=$bookId', method: 'GET');
    if (response.statusCode == 200){
      List<dynamic> result = json.decode(response.body);
      print(result);
      return result.map((data) => Word.fromJson(data)).toList();
    } 
    else throw Exception('Unable to fetch words.');
  }
}