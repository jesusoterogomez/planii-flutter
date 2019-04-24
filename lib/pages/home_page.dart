import 'package:flutter/material.dart';
import 'package:planii/bloc/navigation.dart';
import 'package:planii/pages/user_profile_page.dart';
import 'package:planii/pages/feed_page.dart';

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
            child: getRoute(tabIndex),
          ),
          bottomNavigationBar: new BottomNavigationBar(
            currentIndex: tabIndex,
            onTap: bloc.updateCurrentTab,
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

Widget getRoute(int routeIndex) {
  switch (routeIndex) {
    case 0:
      return new FeedPage();
    case 1:
      return new Text("Page $routeIndex");
    case 2:
      return new UserProfilePage();
    default:
      return new Text("Not found! $routeIndex");
  }
}
