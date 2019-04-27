import 'package:flutter/material.dart';
import 'package:planii/bloc/navigation.dart';
import 'package:planii/pages/user_profile_page.dart';
import 'package:planii/pages/feed_page.dart';
import 'package:planii/pages/create_plan_page.dart';

enum Routes {
  feed,
  create_new,
  profile,
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = NavigationProvider.of(context);

    return StreamBuilder(
      stream: bloc.currentTab,
      initialData: bloc.initialData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int tabIndex = snapshot.data;

        return Scaffold(
          body: Center(
            child: getRoute(tabIndex, context),
          ),
          bottomNavigationBar: new BottomNavigationBar(
            currentIndex: tabIndex,
            onTap: (int index) => updateTab(index, bloc, context),
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: new Icon(Icons.format_list_bulleted),
                title: new Text('Feed'),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.add_circle_outline),
                title: new Text('Create new'),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.person_outline),
                title: new Text('Profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}

void updateTab(int routeIndex, NavigationBloc bloc, BuildContext context) {
  Routes _route = Routes.values[routeIndex];

  // The create_new route will redirect to a new page instead of navigating in tabs
  if (_route == Routes.create_new) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePlanPage(),
      ),
    );

    return null;
  }

  return bloc.updateCurrentTab(routeIndex);
}

Widget getRoute(int routeIndex, context) {
  switch (Routes.values[routeIndex]) {
    case Routes.feed:
      return new FeedPage();
    case Routes.profile:
      return new UserProfilePage();
    default:
      return new Text("Not found! $routeIndex");
  }
}
