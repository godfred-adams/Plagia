import 'package:flutter/material.dart';

class CheckPlagiarismPage extends StatelessWidget {
  const CheckPlagiarismPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text(
              'Assignment_1.pdf',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Text from document',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    // textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const WelcomeScreen()),
                        // );
                      },
                      child: const Text(
                        'Check Plagiarism',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ((context) => const CheckPlagiarismPage()),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      color: Colors.black,
                      child: const Text(
                        'Bottom Navigation Bar here',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
