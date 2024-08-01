import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';

import '../utils/navigation_provider.dart';

// Define a StateProvider for the search query
final searchQueryProvider = StateProvider<String>((ref) => '');

class FilesScreen extends ConsumerWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the current search query
    final searchQuery = ref.watch(searchQueryProvider);

    // Generate a list of files (or adjust to your actual data source)
    final List<int> filesList = List.generate(20, (index) => index);

    // Filter the list based on the search query
    final filteredFilesList = filesList.where((file) {
      final fileName = 'File $file'; // Example file name
      return fileName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return buildLightThemeBackground(
      mainWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(bottomNavIndexProvider.notifier).setIndex(0);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.33),
              const Text(
                'Recent Files',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (query) {
              // Update the search query
              ref.read(searchQueryProvider.notifier).state = query;
            },
            decoration: InputDecoration(
              hintText: 'Search',
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: const Icon(Icons.search, color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'All Documents',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFilesList.length,
              itemBuilder: (context, index) {
                final file = filteredFilesList[index];
                final fileName = 'File $file'; // Example file name
                return buildModifiedDocumentList(
                    fileName, '1.5 MB - 13 January 2024, 17:00', searchQuery);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildModifiedDocumentList(
    String title, String subtitle, String searchQuery) {
  // Highlight matching text
  TextSpan highlightText(String text, String query) {
    if (query.isEmpty) {
      return TextSpan(text: text);
    }

    final regex = RegExp('($query)', caseSensitive: false);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return TextSpan(text: text);
    }

    final parts = <TextSpan>[];
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        parts.add(TextSpan(text: text.substring(start, match.start)));
      }
      parts.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(
          backgroundColor: Colors.yellow.withOpacity(0.3),
          fontWeight: FontWeight.bold,
        ),
      ));
      start = match.end;
    }

    if (start < text.length) {
      parts.add(TextSpan(text: text.substring(start)));
    }

    return TextSpan(children: parts);
  }

  return Card(
    color: Colors.white.withOpacity(0.8),
    child: ListTile(
      leading: Image.asset('assets/images/pdf.png'),
      title: RichText(
        text: highlightText(title, searchQuery),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: const Icon(Icons.more_vert),
    ),
  );
}


//import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plagia_oc/widgets/build_light_theme_background.dart';

// import '../utils/navigation_provider.dart';

// // Define a StateProvider for the search query
// final searchQueryProvider = StateProvider<String>((ref) => '');

// class FilesScreen extends ConsumerWidget {
//   const FilesScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Access the current search query
//     final searchQuery = ref.watch(searchQueryProvider);

//     // Generate a list of files (or adjust to your actual data source)
//     final List<int> filesList = List.generate(20, (index) => index);

//     // Filter the list based on the search query
//     final filteredFilesList = filesList.where((file) {
//       final fileName = 'File $file'; // Example file name
//       return fileName.toLowerCase().contains(searchQuery.toLowerCase());
//     }).toList();

//     return buildLightThemeBackground(
//       mainWidget: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   ref.read(bottomNavIndexProvider.notifier).setIndex(0);
//                 },
//                 icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * 0.33),
//               const Text(
//                 'Recent Files',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               const Spacer(),
//             ],
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             onChanged: (query) {
//               // Update the search query
//               ref.read(searchQueryProvider.notifier).state = query;
//             },
//             decoration: InputDecoration(
//               hintText: 'Search',
//               filled: true,
//               fillColor: Colors.grey[300],
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//               suffixIcon: const Icon(Icons.search, color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'All Documents',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredFilesList.length,
//               itemBuilder: (context, index) {
//                 final file = filteredFilesList[index];
//                 final fileName = 'File $file'; // Example file name
//                 return buildModifiedDocumentList(
//                     fileName, '1.5 MB - 13 January 2024, 17:00', searchQuery);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// Widget buildModifiedDocumentList(
//     String title, String subtitle, String searchQuery) {
//   // Highlight matching text
//   TextSpan highlightText(String text, String query) {
//     if (query.isEmpty) {
//       return TextSpan(text: text);
//     }

//     final regex = RegExp('($query)', caseSensitive: false);
//     final matches = regex.allMatches(text);

//     if (matches.isEmpty) {
//       return TextSpan(text: text);
//     }

//     final parts = <TextSpan>[];
//     int start = 0;

//     for (final match in matches) {
//       if (match.start > start) {
//         parts.add(TextSpan(text: text.substring(start, match.start)));
//       }
//       parts.add(TextSpan(
//         text: text.substring(match.start, match.end),
//         style: TextStyle(
//           backgroundColor: Colors.yellow.withOpacity(0.3),
//           fontWeight: FontWeight.bold,
//         ),
//       ));
//       start = match.end;
//     }

//     if (start < text.length) {
//       parts.add(TextSpan(text: text.substring(start)));
//     }

//     return TextSpan(children: parts);
//   }

//   return Card(
//     color: Colors.white.withOpacity(0.8),
//     child: ListTile(
//       leading: Image.asset('assets/images/pdf.png'),
//       title: RichText(
//         text: highlightText(title, searchQuery),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: const TextStyle(fontSize: 14),
//       ),
//       trailing: const Icon(Icons.more_vert),
//     ),
//   );
// }
