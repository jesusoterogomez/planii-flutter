import 'package:flutter/material.dart';
import 'package:planii/bloc/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Log in to Planii'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LoginButton(),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialButton(
            onPressed: () => bloc.signOut(),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Signout'),
          );
        } else {
          return MaterialButton(
            onPressed: () => bloc.googleSignIn(),
            color: Colors.white,
            textColor: Colors.black,
            child: Text('Login with Google'),
          );
        }
      },
    );
  }
}
