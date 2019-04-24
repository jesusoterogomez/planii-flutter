import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  String id;
  String title;
  String location;
  String description;
  Timestamp created;
  Timestamp time;
  PlanAuthor author;
  PlanCoverImage coverImage;

  Plan.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data;

    id = snapshot.documentID;
    title = data['title'];
    location = data['location'];
    description = data['description'];
    created = data['created'];
    time = data['time'];
    author = PlanAuthor(data['author']);
    coverImage = PlanCoverImage(data['coverImage']);
  }
}

class PlanCoverImage {
  String id;
  String downloadUrl = '';

  PlanCoverImage(data) {
    if (data == null) {
      return;
    }

    this.id = data['id'];
    this.downloadUrl = data['downloadUrl'];
  }
}

class PlanAuthor {
  String uid;
  String displayName;
  String avatarUrl;

  PlanAuthor(data) {
    this.uid = data['uid'];
    this.displayName = data['displayName'];
    this.avatarUrl = data['avatarUrl'];
  }
}
