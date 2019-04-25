import 'package:flutter/material.dart';
import 'pages/root_page.dart';

import 'bloc/auth.dart';
import 'bloc/navigation.dart';
import 'bloc/analytics.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      child: AnalyticsProvider(
        child: NavigationProvider(
          child: MaterialApp(
            title: 'Planii',
            theme: new ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: new RootPage(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
