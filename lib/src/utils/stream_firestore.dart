import 'package:cloud_firestore/cloud_firestore.dart';

class StreamFireStore {
  const StreamFireStore();

  // Takes a collection path to the currently configured Firestore Database
  // Returns a QuerySnapshot
  static Stream<QuerySnapshot<Map<String, dynamic>>> _returnCollectionSnapshot(
          {required String collectionPath}) =>
      FirebaseFirestore.instance.collection(collectionPath).snapshots();

// Takes a QuerySnapshot as an argument
// Returns a list of all QueryDocumentSnapshots
  static Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _returnListDocs(
              {required Stream<QuerySnapshot<Map<String, dynamic>>>
                  snapshot}) =>
          snapshot.map((snapshot) => snapshot.docs.map((doc) => doc).toList());

// Takes a list of QueryDocumentSnapshots as a argument
// Returns a list of QueryDocumentSnapshots.data()
  static Stream<List<Map<String, dynamic>>> _returnListDocsData(
          {required Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              documentSnapshots}) =>
      documentSnapshots
          .map((snapshot) => snapshot.map((doc) => doc.data()).toList());

// Presents a list of QueryDocumentSnapshots.data() to the user
  static Stream<List<Map<String, dynamic>>> getListDocsData(
          {required String collectionPath}) =>
      StreamFireStore._returnListDocsData(
        documentSnapshots: _returnListDocs(
          snapshot: _returnCollectionSnapshot(collectionPath: collectionPath),
        ),
      );
}
