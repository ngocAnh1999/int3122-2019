import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Unit.dart';

import 'StrapiRequest.dart';

class UnitServices {

  final Firestore firestore = Firestore.instance;
  final StrapiReq req = new StrapiReq();

  Future<List<Unit>> getEUnitOf(Book book) async {
    QuerySnapshot result = await firestore.collection('EnglishBook').document(book.docId).collection('units').orderBy('name').getDocuments();
    return result.documents.map((snapshot) => Unit.fromESnapshot(snapshot)).toList();
  }

  Future<List<Unit>> getUnitsOf(int bookId) async {
    final response = await req.request('units?book=' + bookId.toString(), method: 'GET');
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      print(result);
      return result.map((data) => Unit.fromMappedJson(data)).toList();
    }
    else
      throw Exception('Unable to get units.');
  }

  Future<Unit> postUnit(Unit unit,int bookId) async {
    Map<String,dynamic> data = unit.toStrJson(bookId);
    final response = await req.request('units',body: data,method: 'POST');
    if (response.statusCode == 200) {
      return Unit.fromMappedJson(json.decode(response.body));
    } else {
      throw Exception('Unable to post unit');
    }
  }

  Future<Unit> getUnitWith(String name, int bookId) async{
    String unitName = name.replaceAll("?", "%3F");
    unitName = unitName.replaceAll(" ", "%20");
    unitName = unitName.replaceAll("000", "%27");
    unitName = unitName.replaceAll("090", "%E2%80%99");
    unitName = unitName.replaceAll("!", "%21");
    final response = await req.request("units?book=" + bookId.toString() + "&name=" + unitName,method: 'GET');
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      if (list.length > 0)
        return Unit.fromMappedJson(list[0]);
      else throw Exception("No unit suitable" + name + "///" + bookId.toString());
    } else {
      throw Exception("Unable to get unit");
    }
  }

}