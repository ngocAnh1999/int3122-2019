import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/models/UserSearch.dart';
import 'package:quizlet_clone/core/utilities/HttpService.dart';
import 'package:quizlet_clone/core/utilities/StrapiConfig.dart';

class SearchService {
  static Future<List<Lesson>> searchLesson({@required String key}) async {
    var response = await HttpService.get(
        endpoint: StrapiConfig.lessonEndpoint,
        params: {'title_contains': key}) as List;
    return new List<Lesson>.from(
        response.map((l) => Lesson.fromMap(l, l['id'])));
  }

  static Future<List<UserSearch>> searchUser({@required String key}) async {
    var response = await HttpService.get(
        endpoint: StrapiConfig.firebaseUserEndpoint,
        params: {'username_contains': key}) as List;
    return new List<UserSearch>.from(
        response.map((u) => UserSearch.fromJson(u)));
  }
}