import 'package:flutter/material.dart';
import 'guests_bloc.dart';

class GuestsProvider extends InheritedWidget {
  final GuestsBloc bloc;

  GuestsProvider({Key key, Widget child, String planId})
      : bloc = GuestsBloc(planId),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static GuestsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<GuestsProvider>()).bloc;
  }
}
