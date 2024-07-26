// import 'package:flutter/material.dart';
// import 'package:ff_navigation_bar/ff_navigation_bar.dart';


// class BottomNavigationBar extends StatelessWidget {
//   const BottomNavigationBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return bottomNavigationBar: FFNavigationBar(
//         theme: FFNavigationBarTheme(
//           barBackgroundColor: Colors.white,
//           selectedItemBorderColor: Colors.transparent,
//           selectedItemBackgroundColor: Colors.green,
//           selectedItemIconColor: Colors.white,
//           selectedItemLabelColor: Colors.black,
//           showSelectedItemShadow: false,
//           barHeight: 70,
//         ),
//         selectedIndex: selectedIndex,
//         onSelectTab: (index) {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         items: [
//           FFNavigationBarItem(
//             iconData: Icons.calendar_today,
//             label: 'Bar Theme',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.people,
//             label: 'Orange',
//             selectedBackgroundColor: Colors.orange,
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.attach_money,
//             label: 'Purple',
//             selectedBackgroundColor: Colors.purple,
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.note,
//             label: 'Blue',
//             selectedBackgroundColor: Colors.blue,
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.settings,
//             label: 'Red Item',
//             selectedBackgroundColor: Colors.red,
//           ),;
//   }
// }