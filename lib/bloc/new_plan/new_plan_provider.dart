import 'package:flutter/material.dart';
import 'new_plan_bloc.dart';

class NewPlanProvider extends InheritedWidget {
  final NewPlanBloc bloc;

  NewPlanProvider({Key key, Widget child})
      : bloc = newPlanBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NewPlanBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NewPlanProvider)
            as NewPlanProvider)
        .bloc;
  }
}
