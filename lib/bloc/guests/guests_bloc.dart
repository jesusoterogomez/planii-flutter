import 'package:firebase_auth/firebase_auth.dart';
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
  final currentUserResponse = new BehaviorSubject<String>();

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

    Guests guestList = Guests.fromSnapshot(snapshot);
    guests.add(guestList);

    String response = await getCurrentUserResponse(guestList);
    currentUserResponse.add(response);
  }

  Future<String> getCurrentUserResponse(Guests guestList) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    // If guestlist is empty
    if (guestList == null) {
      return null;
    }

    // If current user is not in guest list
    Guest _guest = guestList.map[user.uid];
    if (_guest == null) {
      return null;
    }

    return _guest.answer;
  }

  void saveCurrentUserResponse(String answer) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return ref.setData({
      user.uid: {
        'displayName': user.displayName,
        'avatarUrl': user.photoUrl,
        'answer': answer,
        'timestamp': DateTime.now(),
      }
    }, merge: true);
  }
}
