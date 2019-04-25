import 'package:flutter/material.dart';
import 'analytics_bloc.dart';

class AnalyticsProvider extends InheritedWidget {
  final AnalyticsBloc bloc;

  AnalyticsProvider({Key key, Widget child})
      : bloc = analyticsBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AnalyticsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AnalyticsProvider)
            as AnalyticsProvider)
        .bloc;
  }
}
