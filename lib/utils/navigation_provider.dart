import 'package:riverpod/riverpod.dart';

final bottomNavIndexProvider =
    StateNotifierProvider<BottomNavIndexNotifier, int>((ref) {
  return BottomNavIndexNotifier();
});

class BottomNavIndexNotifier extends StateNotifier<int> {
  BottomNavIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}
