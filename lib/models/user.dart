import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/main.dart';
import 'package:intl/intl.dart';

class UserService {

  final String uid;
  UserService({required this.uid});

  final CollectionReference contactsCollection = FirebaseFirestore.instance.collection('contacts');
  final DocumentReference userDocument = FirebaseFirestore.instance.collection('Users').doc(purchaserInfo!.originalAppUserId);

  Future<void> createUserData(String name, String user,Timestamp? lastSeen, bool? isOnline, String documentId, String token, Timestamp createdAt) async {
    await contactsCollection.doc(uid).set({
      'name': name,
      'user': user,
      'last_seen': null,
      'is_online': null,
      'document_id': documentId,
      'notification_token': token,
      'created_at': createdAt,
    });

    await userDocument.update({
      'contacts': FieldValue.increment(1), 
    });
  }

  Future<void> deleteUserData() async {
    await contactsCollection.doc(uid).delete();
    await userDocument.update({
      'contacts': FieldValue.increment(-1),
    });
  }

  Future<void> addtoDatabase() async {
  final _usersDb = FirebaseFirestore.instance.collection('Users');
  DocumentSnapshot _docRef = await _usersDb.doc(purchaserInfo!.originalAppUserId).get();
    if(_docRef.data() == null){
      _usersDb.doc(purchaserInfo!.originalAppUserId).set({
        'user_id': purchaserInfo!.originalAppUserId,
        'subscribe': purchaserInfo!.activeSubscriptions.contains('Premium'),
        'first_seen': DateTime.parse(DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.parse(purchaserInfo!.firstSeen))),
        'contacts': 0,
      });
    }
  }

  
}