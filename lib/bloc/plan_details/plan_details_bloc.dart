import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planii/models/plans_model.dart';

const DB_COLLECTION = 'plans';

class PlanDetailsBloc {
  final id;
  final Firestore _db = Firestore.instance;
  CollectionReference collection;
  DocumentReference ref;

  // Streams
  Observable<DocumentSnapshot> documentState;

  final plan = new BehaviorSubject();

  // Constructor
  PlanDetailsBloc(this.id) {
    // Create reference to DB collection
    collection = _db.collection(DB_COLLECTION);
    ref = collection.document(this.id);

    // Reload plans on DB change
    _onCollectionChanged();
  }

  void _onCollectionChanged() {
    documentState = Observable(ref.snapshots());
    documentState.listen((data) => getPlan());
  }

  void getPlan() async {
    DocumentSnapshot snapshot = await ref.get();

    plan.add(Plan.fromSnapshot(snapshot));
  }
}
