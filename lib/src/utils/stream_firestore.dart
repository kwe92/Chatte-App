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
//TODO: Maybe shorten the implementation a bit an need to make descending optional
  static Query<Map<String, dynamic>> _returnCollectionOrdered(
          {required CollectionReference<Map<String, dynamic>> collectionRef,
          required String orderBy,
          bool descending = true}) =>
      collectionRef.orderBy(orderBy, descending: descending);

  /// Takes a [CollectionReference] to the currently configured [FirebaseFirestore]
  /// Returns a [QuerySnapshot]
  /// The returned [QuerySnapshot] contains the results of a query
  /// It can contain zero or more [DocumentSnapshot] objects

  static Stream<QuerySnapshot<Map<String, dynamic>>> _returnCollectionSnapshot(
          {required CollectionReference<Map<String, dynamic>> collectionRef,
          String? orderBy}) =>
      orderBy == null
          ? collectionRef.snapshots()
          : _returnCollectionOrdered(
                  collectionRef: collectionRef, orderBy: orderBy)
              .snapshots();

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

  /// Returns all documents of a given collection as a [List] of [Map]'s
  static Stream<List<Map<String, dynamic>>> getListDocsData(
          {required String collectionPath, String? orderBy}) =>
      StreamFireStore._returnListDocsData(
        documentSnapshots: _returnListDocsSnapshot(
          snapshot: _returnCollectionSnapshot(
              collectionRef: _returnCollection(
                  firestore: StreamFireStore._firebaseFirestore,
                  collectionPath: collectionPath),
              orderBy: orderBy),
        ),
      );
}
