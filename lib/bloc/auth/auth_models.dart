import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String uid;
  String email;
  String displayName;
  String avatarUrl;
  Timestamp lastSeen;

  UserProfile.fromDB(data) {
    uid = data['uid'];
    email = data['email'];
    displayName = data['displayName'];
    avatarUrl = data['avatarUrl'];
    lastSeen = data['lastSeen'];
  }

  UserProfile();
}
