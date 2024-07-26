// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plag_app/theme_notifier.dart';

// class CustomAppBar extends ConsumerWidget with PreferredSizeWidget {
//   @override
//   final Size preferredSize;

//   CustomAppBar({Key? key})
//       : preferredSize = const Size.fromHeight(kToolbarHeight),
//         super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final ThemeNotifier = ref.watch(themeNotifierProvider);

//     return AppBar(
//       title: Text('App Title'),
//       actions: [
//         IconButton(onPressed: () => ref.read((themeNotifierProvider.notifier).toggleTheme(),), icon: Icon(ThemeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode),),
//       ],
//     )
//   }
// }
