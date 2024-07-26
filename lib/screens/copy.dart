import 'package:flutter/material.dart';

import '../widgets/build_light_theme_background.dart';

class CopyScreen extends StatelessWidget {
  const CopyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return buildLightThemeBackground(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 12.0),
      //       child: IconButton(
      //         onPressed: () {},
      //         icon: const Icon(Icons.dark_mode_outlined),
      //       ),
      //     ),
      //   ],
      // ),
      mainWidget: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, John Doe!",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconOption(Icons.upload_file, "Upload Document"),
                _buildIconOption(Icons.text_fields, "OCR"),
                _buildIconOption(Icons.edit, "Paraphrase"),
                _buildIconOption(Icons.mic, "Voice to Text"),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Pinned 📌",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPinnedDocument("Doc_1.pdf"),
                  _buildPinnedDocument("Doc_2.pdf"),
                  _buildPinnedDocument("Doc_3.pdf"),
                  _buildPinnedDocument("Doc_4.pdf"),
                  _buildPinnedDocument("Doc_5.pdf"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Last Modified",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            _buildModifiedDocumentList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Play',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.folder_open),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      // context: context,
    );
  }

  Widget _buildIconOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white.withOpacity(0.8),
          child: Icon(icon, color: Colors.black, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPinnedDocument(String fileName) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const Icon(Icons.picture_as_pdf, size: 50, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            fileName,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildModifiedDocumentList() {
    List<String> documents = [
      "THE USE OF AI IN CHEMICAL ENGINEERING.pdf",
      "THE USE OF AI IN CHEMICAL ENGINEERING.pdf",
      "THE USE OF AI IN CHEMICAL ENGINEERING.pdf",
      "THE USE OF AI IN CHEMICAL ENGINEERING.pdf",
      "THE USE OF AI IN CHEMICAL ENGINEERING.pdf",
    ];
    return Column(
      children: documents.map((doc) {
        return Card(
          color: Colors.white.withOpacity(0.8),
          child: ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
            title: Text(doc),
            subtitle: const Text("1.5 MB - 13 January 2024, 05:00 PM"),
            trailing: const Icon(Icons.more_vert),
          ),
        );
      }).toList(),
    );
  }
}
