import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:plagia_oc/screens/read_online_pdf.dart';
import 'package:plagia_oc/screens/texteditor.dart';
import 'package:plagia_oc/utils/user_provider.dart';
import 'package:plagia_oc/utils/usermodel.dart';
import 'package:plagia_oc/widgets/build_light_theme_background.dart';
import 'package:plagia_oc/widgets/build_modified_document_list.dart';

import '../../../utils/navigation_provider.dart';

// Define a StateProvider for the search query
final searchQueryProvider = StateProvider<String>((ref) => '');

class FilesScreen extends ConsumerStatefulWidget {
  const FilesScreen({super.key});

  @override
  ConsumerState<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends ConsumerState<FilesScreen> {
  bool isLoading = false;
  UserModel? user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> loadUser() async {
    setState(() {
      isLoading = true;
    });
    final loadedUser = await ref.read(userProvider.notifier).loadUser();
    debugPrint(loadedUser.toString());
    setState(() {
      user = loadedUser;
      isLoading = false;
    });
    print(user);
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    // Access the current search query

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff070c16),
              title: const Text(
                'All Files',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         ref.read(bottomNavIndexProvider.notifier).setIndex(0);
                  //       },
                  //       icon: const Icon(Icons.arrow_back_ios,
                  //           color: Colors.orange),
                  //     ),
                  //     SizedBox(width: MediaQuery.of(context).size.width * 0.27),
                  //     const Text(
                  //       'All Files',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 24,
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //   ],
                  // ),
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
                      suffixIcon:
                          const Icon(IconlyLight.search, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Documents acccessed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: SingleChildScrollView(
                      // physics: const BouncingScrollPhysics(),
                      child: StreamBuilder(
                        stream: firestore
                            .collection('pdfs')
                            .doc(user!.uid)
                            .collection('pdf')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              !snapshot.data!.docs.isNotEmpty) {
                            return const Center(child: Text('No PDFs found.'));
                          }
                          final pdfDocuments = snapshot.data!.docs;
                          // print(pdfDocuments.docs.length);
                          return SizedBox(
                            height: 900,
                            child: ListView.builder(
                              itemCount: pdfDocuments.length,
                              itemBuilder: (context, index) {
                                final pdfData = pdfDocuments[index].data()
                                    as Map<String, dynamic>;
                                final pdfName = pdfData['fileName'];
                                print(pdfData['url']);
                                final Timestamp timestamp =
                                    pdfData['uploadedAt'];
                                final DateTime dateTime = timestamp.toDate();
                                final String formattedDate =
                                    "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReadOnlinePdf(
                                            filename: pdfName,
                                            url: pdfData['url']),
                                      )),
                                  child: buildModifiedDocumentList(
                                    filename: pdfName,
                                    date: formattedDate,
                                    context: context,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
