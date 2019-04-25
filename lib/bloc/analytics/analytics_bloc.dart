// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:planii/models/auth_models.dart';
// import 'auth_states.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsBloc {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  // Streams
  FirebaseAnalyticsObserver observer;

  // Constructor
  AnalyticsBloc() {
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }
}

// Instantiate
final AnalyticsBloc analyticsBloc = AnalyticsBloc();
