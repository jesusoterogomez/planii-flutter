import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planii/models/plans_model.dart';

const DB_COLLECTION = 'plans';

class PlansBloc {
  final Firestore _db = Firestore.instance;
  CollectionReference collection;

  // Streams
  Observable<QuerySnapshot> collectionState;

  final plans = new BehaviorSubject();

  // Constructor
  PlansBloc() {
    // Create reference to DB collection
    collection = _db.collection(DB_COLLECTION);

    // Reload plans on DB change
    _onCollectionChanged();

    // Fetch data
    getPlans();
  }

  void _onCollectionChanged() {
    collectionState = Observable(collection.snapshots());
    collectionState.listen((data) => getPlans());
  }

  void getPlans([String filter]) async {
    CollectionReference collection = _db.collection(DB_COLLECTION);

    QuerySnapshot snapshot = await collection
        .orderBy(
          'created',
          descending: true,
        )
        .getDocuments();

    // Extract data from snapshots
    Iterable data =
        snapshot.documents.map((DocumentSnapshot s) => Plan.fromSnapshot(s));

    plans.add(data.toList());
  }
}

// Instantiate
final PlansBloc plansBloc = PlansBloc();
