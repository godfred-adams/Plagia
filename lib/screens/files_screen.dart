import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:plagia_oc/screens/texteditor.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';
import 'package:plagia_oc/widgets/build_modified_document_list.dart';

import '../../../utils/navigation_provider.dart';

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
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(bottomNavIndexProvider.notifier).setIndex(0);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.27),
              const Text(
                'All Files',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
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
              suffixIcon: const Icon(IconlyLight.search, color: Colors.black),
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
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuillEditorExample())),
                    child:
                        buildModifiedDocumentList(date: null, filename: null));
                // fileName, '1.5 MB - 13 January 2024, 17:00', searchQuery);
              },
            ),
          ),
        ],
      ),
    );
  }
}
