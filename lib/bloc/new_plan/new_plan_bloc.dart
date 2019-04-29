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
  final plan = new BehaviorSubject<Plan>();
  Plan planData = new Plan();
  // final newPlanState = new BehaviorSubject<Plan>();

  // Constructor
  NewPlanBloc() {
    // Create reference to DB collection
    collection = _db.collection(DB_COLLECTION);

    // Reload plans on DB change
    // _onCollectionChanged();

    // Fetch data
    // getPlans();
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

  void setPlanLocation(String location) {
    planData.location = location;

    _updatePlan();
  }

  void createPlan() async {
    // Map data = Map.from(plan.value);

    // var t = await collection.add(data);
  }
}

// Instantiate
final NewPlanBloc newPlanBloc = NewPlanBloc();
