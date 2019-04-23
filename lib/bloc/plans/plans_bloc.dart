import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

const DB_COLLECTION = 'plans';

class PlansBloc {
  final Firestore _db = Firestore.instance;

  // Streams
  final plans = new BehaviorSubject();

  // Constructor
  PlansBloc() {
    getPlans();
  }

  getPlans([String filter]) async {
    CollectionReference collection = _db.collection(DB_COLLECTION);

    QuerySnapshot snapshot = await collection.getDocuments();

    // Extract data from snapshots
    Iterable data = snapshot.documents.map((DocumentSnapshot s) => s.data);

    plans.add(data.toList());
  }
}
