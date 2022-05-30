import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final String uid;
  UserService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('contacts');

  Future createUserData(bool? isOnline,String name, int user,Timestamp? lastSeen,String documentId, String token, Timestamp createdAt) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'user': user,
      'last_seen': lastSeen,
      'is_online': isOnline,
      'document_id': documentId,
      'notification_token': token,
      'created_at': createdAt,
    });
  }

  Future<void> updateUserName(String name) async {
    return await userCollection.doc(uid).update({
      'name': name,
    });
  }

  Future deleteUserData() async {
    return await userCollection.doc(uid).delete();
  }

  
}