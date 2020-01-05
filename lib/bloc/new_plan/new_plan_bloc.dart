import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planii/models/plans_model.dart';
import 'new_plan_states.dart';

const DB_COLLECTION = 'plans';

class NewPlanBloc {
  final Firestore _db = Firestore.instance;
  CollectionReference collection;

  // Streams
  // Stores values for new plan being created.
  final plan = new BehaviorSubject<Plan>.seeded(new Plan());

  BehaviorSubject status = BehaviorSubject(); // authentication status

  // Constructor
  NewPlanBloc() {
    // Create reference to DB collection
    collection = _db.collection(DB_COLLECTION);
    status.add(NewPlanStatus.initialized);
  }

  void resetPlan() {
    plan.add(new Plan());
  }

  void setPlanTitle(String title) {
    plan.value.title = title;
    plan.add(plan.value);
  }

  void setPlanDescription(String description) {
    plan.value.description = description;
    plan.add(plan.value);
  }

  void setPlanLocation(String location) {
    plan.value.location = location;
    plan.add(plan.value);
  }

  void setPlanStartTime(DateTime startTime) {
    plan.value.startTime = startTime;
    plan.add(plan.value);
  }

  void setPlanEndTime(DateTime endTime) {
    plan.value.endTime = endTime;
    plan.add(plan.value);
  }

  Future<PlanAuthor> getAuthorDetails() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return PlanAuthor({
      'uid': user.uid,
      'avatarUrl': user.photoUrl,
      'displayName': user.displayName
    });
  }

  void createPlan() async {
    status.add(NewPlanStatus.creating);

    plan.value.author = await getAuthorDetails();
    plan.value.created = DateTime.now();

    // Prepare to send data
    Map data = plan.value.toMap();

    print('Added plan: $data');
    await collection.add(data);

    status.add(NewPlanStatus.created);

    // Wait for a couple of seconds to display success message

    status.add(NewPlanStatus.initialized);
  }
}

// Instantiate
final NewPlanBloc newPlanBloc = NewPlanBloc();
