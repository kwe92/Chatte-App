import 'package:cloud_firestore/cloud_firestore.dart';

class StreamFireStore {
  const StreamFireStore();

  /// [FirebaseFirestore] instance
  static FirebaseFirestore get _firebaseFirestore => FirebaseFirestore.instance;

  /// [CollectionReference] to the specified Firestore collection path
  static CollectionReference<Map<String, dynamic>> _returnCollection(
          {required FirebaseFirestore firestore,
          required String collectionPath}) =>
      firestore.collection(collectionPath);

  /// Takes a [CollectionReference] to the currently configured [FirebaseFirestore]
  /// Returns a [QuerySnapshot]
  /// The returned [QuerySnapshot] contains the results of a query
  /// It can contain zero or more [DocumentSnapshot] objects

  static Stream<QuerySnapshot<Map<String, dynamic>>> _returnCollectionSnapshot(
          {required CollectionReference<Map<String, dynamic>> collectionRef}) =>
      collectionRef.snapshots();

  /// Takes a [QuerySnapshot] as an argument
  /// Returns a [List] of all [QueryDocumentSnapshot] objects
  /// A [QueryDocumentSnapshot] object
  /// contains data read from a document in your [FirebaseFirestore]
  /// database as part of a query

  static Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _returnListDocsSnapshot(
              {required Stream<QuerySnapshot<Map<String, dynamic>>>
                  snapshot}) =>
          snapshot.map((snapshot) => snapshot.docs);

  /// Takes a [List] of [QueryDocumentSnapshot] objects as a argument
  /// Returns a [List] of each [QueryDocumentSnapshot] objects data as a [Map]

  static Stream<List<Map<String, dynamic>>> _returnListDocsData(
          {required Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              documentSnapshots}) =>
      documentSnapshots.map((listDocSnapshot) =>
          listDocSnapshot.map((doc) => doc.data()).toList());

  /// Returns a [List] of [Map]<String,dynamic> to the user
  static Stream<List<Map<String, dynamic>>> getListDocsData(
          {required String collectionPath}) =>
      StreamFireStore._returnListDocsData(
        documentSnapshots: _returnListDocsSnapshot(
          snapshot: _returnCollectionSnapshot(
            collectionRef: _returnCollection(
                firestore: StreamFireStore._firebaseFirestore,
                collectionPath: collectionPath),
          ),
        ),
      );
}
