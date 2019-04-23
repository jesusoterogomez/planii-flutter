import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

const DB_COLLECTION = 'plans';

class Plan {
  String title;
  String location;
  String description;
  String coverImage = '';

  Plan.fromDB(data) {
    title = data['title'];
    location = data['location'];
    description = data['description'];

    if (data['coverImage'] != null) {
      coverImage = data['coverImage']['downloadUrl'];
    }
  }
}

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
        snapshot.documents.map((DocumentSnapshot s) => new Plan.fromDB(s.data));

    plans.add(data.toList());
  }
}
