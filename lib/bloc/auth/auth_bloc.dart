import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planii/models/auth_model.dart';
import 'auth_states.dart';

class AuthBloc {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  // Streams
  Observable<FirebaseUser> user;
  BehaviorSubject profile = BehaviorSubject(); // User data in Firestore
  BehaviorSubject status = BehaviorSubject(); // authentication status

  // Constructor
  AuthBloc() {
    // Initialize
    status.add(AuthStatus.uninitialized);
    user = Observable(_auth.onAuthStateChanged);

    // Subscriptions

    // When user changes, update profile state.
    user.listen((u) => updateUserProfile(u));

    // Read current user
    currentUser();
  }

  void updateUserProfile(FirebaseUser u) async {
    if (u == null) {
      currentUser();
      return profile.add({});
    }

    DocumentReference document = _db.collection('users').document(u.uid);
    DocumentSnapshot snapshot = await document.get();

    if (snapshot.exists) {
      currentUser();
      return profile.add(UserProfile.fromSnapshot(snapshot));
    }

    return profile.add({});
  }

  Future<FirebaseUser> googleSignIn() async {
    status.add(AuthStatus.loading);

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    updateUserData(user);

    // Done
    status.add(AuthStatus.authenticated);
    return user;
  }

  Future<FirebaseUser> currentUser() async {
    status.add(AuthStatus.loading);

    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      status.add(AuthStatus.unauthenticated);
      return null;
    }

    updateUserData(user);

    status.add(AuthStatus.authenticated);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'avatarUrl': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }
}

// Instantiate
final AuthBloc authBloc = AuthBloc();
