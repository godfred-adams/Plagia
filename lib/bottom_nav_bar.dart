import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';

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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent, // Minimizes the ripple effect
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(bottomNavIndexProvider.notifier).setIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF090B17),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBroken.home),
              activeIcon: Icon(IconlyBold.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.category),
              icon: Icon(IconlyBroken.category),
              label: "Features",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.folder),
              icon: Icon(IconlyBroken.folder),
              label: "Files",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyBroken.profile),
              label: "Profile",
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
