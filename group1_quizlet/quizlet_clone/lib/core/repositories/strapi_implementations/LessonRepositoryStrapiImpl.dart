import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/repositories/LessonRepository.dart';
import 'package:quizlet_clone/core/utilities/HttpService.dart';
import 'package:quizlet_clone/core/utilities/StrapiConfig.dart';

class LessonRepositoryStrapiImpl implements LessonRepository {
  static const _endpoint = StrapiConfig.lessonEndpoint;

  @override
  Future<Lesson> getLessonById({String id}) async {
    var response = await HttpService.get(endpoint: '$_endpoint/$id');
    return Lesson.fromMap(response, response['id']);
  }

  @override
  Future<List<Lesson>> getLessons() async {
    var response = await HttpService.get(endpoint: _endpoint) as List;
    return new List<Lesson>.from(
        response.map((l) => Lesson.fromMap(l, l['id'])));
  }

  @override
  Future<List<Lesson>> getLessonsByUser({@required String username}) async {
    var response = await HttpService.get(
        endpoint: _endpoint, params: {'firebaseuser.username': username}) as List;
    return new List<Lesson>.from(
        response.map((l) => Lesson.fromMap(l, l['id'])));
  }
}
