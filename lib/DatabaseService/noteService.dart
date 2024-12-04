import 'package:cloud_firestore/cloud_firestore.dart';

class NoteService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future NoteDataSave(Map<String, dynamic> data) async {
    return await db.collection('notes').doc().set(data);
  }

  Future<List<QueryDocumentSnapshot>> noteGet(String userId) async {
    try {
      QuerySnapshot snapshot = await db
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .orderBy('time', descending: true)
          .snapshots()
          .first;

      return snapshot.docs;
    } catch (e) {
      return [];
    }
  }

  Future<bool> NoteUpdate(String id, Map<String, dynamic> data) async {
    try {
      await db.collection('notes').doc(id).update(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future NoteDelete(String id) async {
    try {
      await db.collection('notes').doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
