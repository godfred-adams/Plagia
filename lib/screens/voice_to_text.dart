import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:iconly/iconly.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

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
  // double _confidenceLevel = 0;
  final quill.QuillController _inputController = quill.QuillController.basic(
      configurations: const quill.QuillControllerConfigurations());

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff070c16),
        title: const Text(
          'Speech-to-text',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(IconlyBroken.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              // const SizedBox(height: 23),
              // Row(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       icon:
              //           const Icon(Icons.arrow_back_ios, color: Colors.orange),
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.19),
              //     const Text(
              //       'Speech-to-text',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 24,
              //       ),
              //     ),
              //     // const Spacer(),
              //   ],
              // ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    quill.QuillSimpleToolbar(
                      controller: _inputController,
                      configurations:
                          const quill.QuillSimpleToolbarConfigurations(
                        showSuperscript: false,
                        showSubscript: false,
                        showFontSize: false,
                        showFontFamily: false,
                        showStrikeThrough: false,
                        showInlineCode: false,
                        showBackgroundColorButton: false,
                        showClearFormat: false,
                        showHeaderStyle: false,
                        showColorButton: false,
                        showListCheck: false,
                        showQuote: false,
                        showCodeBlock: false,
                        showIndent: false,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.44,
                      child: Column(
                        children: [
                          const SizedBox(height: 14),
                          Text(
                            _isListening
                                ? "Listening... Press again to stop."
                                : _speechEnabled
                                    ? "Tap the microphone to start listening..."
                                    : "Speech not available",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const Divider(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                height: size.height * 0.50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // padding: const EdgeInsets.all(16),
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
                        ],
                      ),

                      // child:
                      // quill.QuillEditor.basic(
                      //   controller: _inputController,
                      // ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Container(
              //   padding: const EdgeInsets.all(16),
              // child: Text(
              //   _isListening
              //       ? "Listening... Press again to stop."
              //       : _speechEnabled
              //           ? "Tap the microphone to start listening..."
              //           : "Speech not available",
              //   style: const TextStyle(fontSize: 20.0),
              // ),
              // ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Container(
              //       height: size.height * 0.46,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 1),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       padding: const EdgeInsets.all(16),
              //       child: Text(
              //         _wordsSpoken,
              //         style: const TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.w300,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // if (!_isListening && _confidenceLevel > 0)
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 100,
              //   ),
              //   child: Text(
              //     "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
              //     style: const TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.w200,
              //     ),
              //   ),
              // ),
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
      ),
    );
  }
}
