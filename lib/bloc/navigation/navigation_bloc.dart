import 'package:rxdart/rxdart.dart';

const DEFAULT_TAB = 0;

class NavigationBloc {
  // Streams
  final currentTab = new BehaviorSubject<int>();

  NavigationBloc() {
    currentTab.add(DEFAULT_TAB);
  }

  void updateCurrentTab(int tabIndex) {
    return currentTab.add(tabIndex);
  }

  int initialData() {
    return DEFAULT_TAB;
  }
}

// Instantiate
final NavigationBloc navigationBloc = NavigationBloc();
