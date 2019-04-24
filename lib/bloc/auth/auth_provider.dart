import 'package:flutter/material.dart';
import 'auth_bloc.dart';

class AuthProvider extends InheritedWidget {
  final AuthBloc bloc;

  AuthProvider({Key key, Widget child})
      : bloc = authBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider)
        .bloc;
  }
}
