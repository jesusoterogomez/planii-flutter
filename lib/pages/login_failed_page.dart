import 'package:planii/bloc/auth.dart';
import 'package:flutter/material.dart';

class LoginFailedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("There was an error logging in"),
            MaterialButton(
              onPressed: () => bloc.resetState(),
              child: Text("Try Again"),
            )
          ],
        ),
      ),
    );
  }
}
