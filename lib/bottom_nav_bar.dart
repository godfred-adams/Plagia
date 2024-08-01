import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/features_screen.dart';
import 'screens/files_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/welcome_screen.dart';
import 'utils/navigation_provider.dart';

class MyBottomNavigation extends ConsumerWidget {
  const MyBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          WelcomeScreen(),
          FeaturesScreen(),
          FilesScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).setIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF090B17),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: "Features",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Files",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: false,
      ),
    );
  }
}
