import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planii/models/guests_model.dart';

const DB_COLLECTION = 'guests';

class GuestsBloc {
  final id;
  final Firestore _db = Firestore.instance;
  CollectionReference collection;
  DocumentReference ref;

  // Streams
  Observable<DocumentSnapshot> documentState;

  final guests = new BehaviorSubject();

  // Constructor
  GuestsBloc(this.id) {
    // Create reference to DB collection
    collection = _db.collection(DB_COLLECTION);
    ref = collection.document(this.id);

    // Reload plans on DB change
    _onDocumentChange();
  }

  void _onDocumentChange() {
    documentState = Observable(ref.snapshots());
    documentState.listen((data) => getGuests());
  }

  void getGuests() async {
    DocumentSnapshot snapshot = await ref.get();

    guests.add(Guests.fromSnapshot(snapshot));
  }
}
