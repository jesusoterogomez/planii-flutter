import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'plans_model.dart';

const DB_COLLECTION = 'plans';

class PlansBloc {
  final Firestore _db = Firestore.instance;

  // Streams
  Observable<QuerySnapshot> dbState;
  final plans = new BehaviorSubject();

  // Constructor
  PlansBloc() {
    getPlans();

    // Reload plans on DB change
    dbState = Observable(_db.collection(DB_COLLECTION).snapshots());
    dbState.listen((data) => getPlans());
  }

  void getPlans([String filter]) async {
    CollectionReference collection = _db.collection(DB_COLLECTION);

    QuerySnapshot snapshot = await collection.getDocuments();

    // Extract data from snapshots
    Iterable data =
        snapshot.documents.map((DocumentSnapshot s) => Plan.fromSnapshot(s));

    plans.add(data.toList());
  }
}

// Instantiate
final PlansBloc plansBloc = PlansBloc();
