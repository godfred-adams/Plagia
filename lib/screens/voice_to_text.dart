import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceToText extends StatefulWidget {
  const VoiceToText({super.key});

  @override
  State<VoiceToText> createState() => _VoiceToTextState();
}

class _VoiceToTextState extends State<VoiceToText>
    with SingleTickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  QuillController _controller = QuillController.basic();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  bool _isListening = false; // Track if the system is listening

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initSpeech();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation1 = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animation2 = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _toggleListening() async {
    if (_isListening) {
      // Stop listening and the animation
      await _speechToText.stop();
      _animationController.stop();
    } else {
      // Start listening and the animation
      await _speechToText.listen(onResult: _onSpeechResult);
      _animationController.forward();
    }

    setState(() {
      _isListening = !_isListening;
    });
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 44),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.30),
                const Text(
                  'Dictate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                _isListening
                    ? "Listening... Press again to stop."
                    : _speechEnabled
                        ? "Tap the microphone to start listening..."
                        : "Speech not available",
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: size.height * 0.46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _wordsSpoken,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
            if (!_isListening && _confidenceLevel > 0)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ),
                child: Text(
                  "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            Positioned(
              bottom: size.height * 0.08,
              child: GestureDetector(
                onTap: _toggleListening,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer Circle (Largest)
                        ScaleTransition(
                          scale: _animation2,
                          child: CircleAvatar(
                            backgroundColor: Colors.orange.withOpacity(0.2),
                            radius: 78,
                          ),
                        ),
                        // Middle Circle
                        ScaleTransition(
                          scale: _animation1,
                          child: CircleAvatar(
                            radius: 62,
                            backgroundColor: Colors.orange.withOpacity(0.4),
                          ),
                        ),
                        // Inner Circle (Smallest, containing the mic image)
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 48,
                          child: Center(
                            child: Image.asset(
                              'assets/images/mic.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}



//import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class VoiceToText extends StatefulWidget {
//   const VoiceToText({super.key});

//   @override
//   State<VoiceToText> createState() => _VoiceToTextState();
// }

// class _VoiceToTextState extends State<VoiceToText> {
//   final SpeechToText _speechToText = SpeechToText();
//   QuillController _controller = QuillController.basic();

//   bool _speechEnabled = false;
//   String _wordsSpoken = "";
//   double _confidenceLevel = 0;

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     initSpeech();
//   }

//   void initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {
//       _confidenceLevel = 0;
//     });
//   }

//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   void _onSpeechResult(result) {
//     setState(() {
//       _wordsSpoken = "${result.recognizedWords}";
//       _confidenceLevel = result.confidence;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       // appBar: AppBar(
//       //   centerTitle: true,
//       //   backgroundColor: Colors.transparent,
//       //   title: const Text(
//       //     'Dictate',
//       //     style: TextStyle(
//       //       fontWeight: FontWeight.bold,
//       //       fontSize: 18,
//       //     ),
//       //   ),
//       // ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 44),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon:
//                         const Icon(Icons.arrow_back_ios, color: Colors.orange)),
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.30),
//                 const Text(
//                   'Dictate',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                   ),
//                 ),
//                 const Spacer(),
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _speechToText.isListening
//                     ? "listening..."
//                     : _speechEnabled
//                         ? "Tap the microphone to start listening..."
//                         : "Speech not available",
//                 style: const TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   height: size.height * 0.46,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1),
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Text(
//                     _wordsSpoken,
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (_speechToText.isNotListening && _confidenceLevel > 0)
//               Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 100,
//                 ),
//                 child: Text(
//                   "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w200,
//                   ),
//                 ),
//               ),
//             Positioned(
//                 bottom: size.height * 0.08,
//                 child: GestureDetector(
//                   onTap: _speechToText.isListening
//                       ? _stopListening
//                       : _startListening,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.orange.withOpacity(0.2),
//                     radius: 82,
//                     child: CircleAvatar(
//                       radius: 68,
//                       backgroundColor: Colors.orange.withOpacity(0.4),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.orange,
//                         radius: 54,
//                         child: Center(
//                           child: Image.asset('assets/images/mic.png', 
                          
//                               fit: BoxFit.cover),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )),
//             SizedBox(height: size.height * 0.03),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _speechToText.isListening ? _stopListening : _startListening,
//       //   tooltip: 'Listen',
//       //   backgroundColor: Colors.red,
//       //   child: Icon(
//       //     _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//       //     color: Colors.white,
//       //   ),
//       // ),
//     );
//   }
// }
