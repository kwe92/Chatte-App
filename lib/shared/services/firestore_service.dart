import 'package:cloud_firestore/cloud_firestore.dart';

/// API to interact with [FirebaseFirestore] collections and documents
class FireStoreService {
  const FireStoreService();

  static FirebaseFirestore get _firebaseFirestore => FirebaseFirestore.instance;

  FirebaseFirestore get instance => _firebaseFirestore;

  /// [CollectionReference] to the specified Firestore collection path.
  CollectionReference<Map<String, dynamic>> _getCollectionReference(
          {required FirebaseFirestore firestoreInstance, required String collectionPath}) =>
      firestoreInstance.collection(collectionPath);

  /// Returns a [QuerySnapshot] containing the results of a query, which can contain zero or more [DocumentSnapshot] objects.
  Stream<QuerySnapshot<Map<String, dynamic>>> _getCollectionSnapshots({
    required CollectionReference<Map<String, dynamic>> collectionRef,
    String? orderBy,
    bool descending = true,
  }) =>
      orderBy == null ? collectionRef.snapshots() : collectionRef.orderBy(orderBy, descending: descending).snapshots();

  /// Returns a [List] of all [QueryDocumentSnapshot] objects containing data read from a document
  /// in your [FirebaseFirestore] database as part of a query.
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _getQueryDocumentSnapshots(
          {required Stream<QuerySnapshot<Map<String, dynamic>>> snapshots}) =>
      snapshots.map((snapshot) => snapshot.docs);

  /// Decodes a [List] of [QueryDocumentSnapshot] objects into a [List] of [Map] objects.
  Stream<List<Map<String, dynamic>>> _decodeQueryDocumentSnapshots(
          {required Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> documentSnapshots}) =>
      documentSnapshots.map((listDocSnapshot) => listDocSnapshot.map((doc) => doc.data()).toList());

  /// Returns all documents of a given collection as a [List] of [Map] objects.
  Stream<List<Map<String, dynamic>>> getAllDocuments({
    required String collectionPath,
    String? orderBy,
    bool descending = true,
  }) =>
      _decodeQueryDocumentSnapshots(
        documentSnapshots: _getQueryDocumentSnapshots(
          snapshots: _getCollectionSnapshots(
            collectionRef: _getCollectionReference(
              firestoreInstance: _firebaseFirestore,
              collectionPath: collectionPath,
            ),
            orderBy: orderBy,
            descending: descending,
          ),
        ),
      );
}
