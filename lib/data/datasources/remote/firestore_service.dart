import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument(String collection, Map<String, dynamic> data) {
    return _firestore.collection(collection).add(data);
  }

  Future<void> setDocument(String collection, String docId, Map<String, dynamic> data) {
    return _firestore.collection(collection).doc(docId).set(data);
  }

  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) {
    return _firestore.collection(collection).doc(docId).update(data);
  }

  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  Future<QuerySnapshot> getCollection(String collection) {
    return _firestore.collection(collection).get();
  }

  Future<DocumentSnapshot> getDocument(String collection, String docId) {
    return _firestore.collection(collection).doc(docId).get();
  }
}
