import 'package:flutter/material.dart';
import 'navigation_bloc.dart';

class NavigationProvider extends InheritedWidget {
  final NavigationBloc bloc;

  NavigationProvider({Key key, Widget child})
      : bloc = navigationBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NavigationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NavigationProvider)
            as NavigationProvider)
        .bloc;
  }
}
