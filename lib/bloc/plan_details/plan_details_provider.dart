import 'package:flutter/material.dart';
import 'plan_details_bloc.dart';

class PlanDetailsProvider extends InheritedWidget {
  final PlanDetailsBloc bloc;

  PlanDetailsProvider({Key key, Widget child, String planId})
      : bloc = PlanDetailsBloc(planId),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static PlanDetailsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<PlanDetailsProvider>())
        .bloc;
  }
}
