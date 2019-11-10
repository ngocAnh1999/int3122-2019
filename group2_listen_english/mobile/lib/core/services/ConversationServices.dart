import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/models/Book.dart';
import 'package:mobile/core/models/Conversation.dart';
import 'package:mobile/core/models/Unit.dart';
import 'StrapiRequest.dart';

class ConversationServices {
  final Firestore firestore = Firestore.instance;
  final StrapiReq req = new StrapiReq();

  /**
   * Get conversations from firebase
   */
  Future<List<Conversation>> getEConversationOf(Book book,Unit unit) async {
    QuerySnapshot result = await firestore.collection('EnglishBook').document(book.docId).collection('units').document(unit.docId).collection('conversations').getDocuments();
    return result.documents.map((snapshot) => Conversation.fromESnapshot(snapshot)).toList();
  }

  /**
   * Post conversation to strapi
   */
  Future<Conversation> postConv(Map<String,dynamic> data) async {
    print(data);
    final response = await req.request("convers",body: data,method: 'POST');
    if (response.statusCode == 200) {
      return Conversation.fromMappedJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch conv');
    }
  }

  /**
   * Get conversations from strapi
   */
  Future<List<Conversation>> getCovOf(Unit unit) async {
    final response = await req.request("convers?unit=" + unit.id.toString(),method: 'GET');
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      return result.map((data) => Conversation.fromMappedJson(data)).toList();
    }
    else
      throw Exception('Unable to get conversations.');
  }

}