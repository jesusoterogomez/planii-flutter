import 'package:flutter/material.dart';
import 'package:planii/bloc/auth.dart';

// Pages
import 'package:planii/pages/login_page.dart';
import 'package:planii/pages/loading_page.dart';
import 'package:planii/pages/splash_page.dart';
import 'package:planii/pages/home_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.status,
      initialData: AuthStatus.uninitialized,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        AuthStatus authStatus = snapshot.data;

        switch (authStatus) {
          case AuthStatus.uninitialized:
            return new SplashPage();
          case AuthStatus.loading:
            return new LoadingPage();
          case AuthStatus.authenticated:
            return new HomePage();
          case AuthStatus.unauthenticated:
          default:
            return new LoginPage();
        }
      },
    );
  }
}
