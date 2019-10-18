import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet_clone/core/models/lesson.dart';

class LessonRepository {
  final CollectionReference ref = Firestore.instance.collection('lessons');

  Future<List<Lesson>> getLessons() async {
    var result = await ref.getDocuments();
    List<Lesson> lessons = result.documents
        .map((doc) => Lesson.fromMap(doc.data, doc.documentID))
        .toList();
    return lessons;
  }

  Future<Lesson> getLessonById(String id) async {
    var doc = await ref.document(id).get();
    return Lesson.fromMap(doc.data, doc.documentID);
  }
}
