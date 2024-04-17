import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanap_app/models/models.dart';

const String missingCollectionRef = "missing";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _missingRef;

  DatabaseService() {
    _missingRef =
        _firestore.collection(missingCollectionRef).withConverter<Content>(
              fromFirestore: (snapshot, _) => Content.fromJson(
                snapshot.data()!,
              ),
              toFirestore: (missing, _) => missing.toJson(),
            );
  }

  Stream<QuerySnapshot> getMissings() {
    return _missingRef.snapshots();
  }

  Future<void> addMissing(Content content) async {
    _missingRef.add(content);
  }
}
