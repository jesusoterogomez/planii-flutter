import 'package:cloud_firestore/cloud_firestore.dart';

// @todo Implement boundaries for answer property in Guest
enum Answers {
  yes,
  no,
  maybe,
}

class Guest {
  String uid;
  String avatarUrl;
  String displayName;
  String answer;

  Guest(String id, dynamic data) {
    uid = id;
    avatarUrl = data['avatarUrl'];
    displayName = data['displayName'];
    answer = data['answer'];
  }
}

class Guests {
  // Map list;
  List<Guest> list = [];

  Guests.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data;

    data.forEach(
      (key, value) => list.add(Guest(key, value)),
    );
  }
}
