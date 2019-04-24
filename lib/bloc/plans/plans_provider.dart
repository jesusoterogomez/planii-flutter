import 'package:flutter/material.dart';
import 'plans_bloc.dart';

class PlansProvider extends InheritedWidget {
  final PlansBloc bloc;

  PlansProvider({Key key, Widget child})
      : bloc = plansBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static PlansBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PlansProvider)
            as PlansProvider)
        .bloc;
  }
}
