import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planii/models/plans_model.dart';

const DB_COLLECTION = 'plans';

class NewPlanBloc {
  final Firestore _db = Firestore.instance;
  CollectionReference collection;

  // Streams
  // Observable<QuerySnapshot> collectionState;

  // Stores values for new plan being created.
  final plan = new BehaviorSubject<Plan>.seeded(new Plan());
  Plan planData = new Plan();
  // final newPlanState = new BehaviorSubject<Plan>();

  // Constructor
  NewPlanBloc() {
    // Create reference to DB collection
    collection = _db.collection(DB_COLLECTION);

    // Reload plans on DB change
    // _onCollectionChanged();

    // Fetch data
  }

  void resetPlan() {
    Plan planData = new Plan();
    plan.add(planData);
  }

  void _updatePlan() {
    plan.add(planData);
  }

  // void _onCollectionChanged() {
  //   collectionState = Observable(collection.snapshots());
  //   collectionState.listen((data) => getPlans());
  // }

  void setPlanTitle(String title) {
    planData.title = title;
    _updatePlan();
  }

  void setPlanDescription(String description) {
    planData.description = description;
    _updatePlan();
  }

  void setPlanLocation(String location) {
    planData.location = location;
    _updatePlan();
  }

  void setPlanTime(DateTime time) {
    planData.time = time;
    _updatePlan();
  }

  void createPlan() async {
    Map data = planData.toMap();
    await collection.add(data);
  }
}

// Instantiate
final NewPlanBloc newPlanBloc = NewPlanBloc();
