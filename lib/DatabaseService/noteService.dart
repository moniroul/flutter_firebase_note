import 'package:cloud_firestore/cloud_firestore.dart';

class NoteService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future NoteDataSave(Map<String, dynamic> data) async {
    return await db.collection('notes').doc().set(data);
  }

  Future<List<QueryDocumentSnapshot>> noteGet(String userId) async {
    QuerySnapshot snapshot = await db
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots().first;

    return snapshot.docs;
  }
}
