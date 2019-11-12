import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizlet_clone/core/models/Lesson.dart';
import 'package:quizlet_clone/core/repositories/LessonRepository.dart';

class LessonRepositoryImpl implements LessonRepository {
  final CollectionReference _ref = Firestore.instance.collection('lessons');

  @override
  Future<List<Lesson>> getLessons() async {
    var result = (await _ref.getDocuments());
    List<Lesson> lessons = result.documents
        .map((doc) => Lesson.fromMap(doc.data, doc.documentID))
        .toList();
    return lessons;
  }

  @override
  Future<Lesson> getLessonById({@required String id}) async {
    var doc = await _ref.document(id).get();
    return Lesson.fromMap(doc.data, doc.documentID);
  }

  @override
  Future<List<Lesson>> getLessonsByUser({String username}) {
    // TODO: implement getLessonsByUser
    return null;
  }
}
