import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  Future<List<DocumentSnapshot>> findUsersById(String userId) async {
    QuerySnapshot result = await Firestore.instance
      .collection('users')
      .where('id', isEqualTo: userId)
      .getDocuments();
    print('Query Result : ${result.documents}');
    return result.documents;
  }

  Future<Null> save(dynamic userData) async { 
    DocumentReference savedUser = await Firestore.instance
      .collection('users')
      .add({
        'name' : userData.displayName,
        'email' : userData.email,
        'id' : userData.uid,
        'avatar_url' : userData.photoUrl,
        'created_at' : DateTime.now().millisecondsSinceEpoch.toString(),
        'status' : 'available'
      });
    print(savedUser);
    return;
  }
}
