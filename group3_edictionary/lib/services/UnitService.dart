import '../models/Unit.dart';
import '../helpers/RequestHelper.dart';
import 'dart:convert';

class UnitService {

  final RequestHelper _requestHelper = RequestHelper();

  Future<List<Unit>> findUnitsByBookId(int bookId) async {
    final response = await _requestHelper.request('units?book_id=$bookId&_sort=number:ASC', method: 'GET');
    if (response.statusCode == 200){
      List<dynamic> result = json.decode(response.body);
      return result.map((data) => Unit.fromJson(data)).toList();
    } 
    else throw Exception('Unable to fetch units.');
  }
}