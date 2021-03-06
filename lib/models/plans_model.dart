import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  String id;
  String title;
  String location;
  String description;
  DateTime created;
  DateTime startTime;
  DateTime endTime;
  PlanAuthor author;
  PlanCoverImage coverImage;

  Plan.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data;

    id = snapshot.documentID;
    title = data['title'];
    location = data['location'];
    description = data['description'];

    created = data['created'] != null ? data['created'].toDate() : null;
    startTime = data['startTime'] != null ? data['startTime'].toDate() : null;
    endTime = data['endTime'] != null ? data['endTime'].toDate() : null;

    author = PlanAuthor(data['author']);
    coverImage = PlanCoverImage(data['coverImage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'description': description,
      'created': created,
      'startTime': startTime,
      'endTime': endTime,
      'author': author != null ? author.toMap() : null,
      'coverImage': coverImage,
    };
  }

  Plan();
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

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }
}
