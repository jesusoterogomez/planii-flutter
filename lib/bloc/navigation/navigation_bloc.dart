import 'package:rxdart/rxdart.dart';

const DEFAULT_TAB = 0;

class NavigationBloc {
  // Streams
  final currentTab = new BehaviorSubject<int>();

  // Constructor
  NavigationBloc();

  int initialData() {
    return DEFAULT_TAB;
  }

  void updateCurrentTab(int tabIndex) {
    return currentTab.add(tabIndex);
  }

  void resetTabs() {
    return currentTab.add(DEFAULT_TAB);
  }

  void previousTab() {
    // Not implemented yet
  }
}
