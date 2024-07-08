import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_highlighter/speech_highlighter.dart';

class SpeechHighlighter extends StatefulWidget {
  final String textToSpeak;
  final SpeechConfig config;

  const SpeechHighlighter({
    super.key,
    required this.textToSpeak,
    this.config = const SpeechConfig(),
  });

  @override
  State<SpeechHighlighter> createState() => SpeechHighlighterState();
}

class SpeechHighlighterState extends State<SpeechHighlighter> {
  FlutterTts flutterTts = FlutterTts();

  int highlightStart = 0;
  int highlightEnd = 0;

  @override
  void initState() {
    super.initState();
    _initTTS();
  }

  void _initTTS() async {
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(widget.config.speechRate);
    flutterTts.setVolume(widget.config.volume);
    flutterTts.setPitch(widget.config.pitch);

    flutterTts.setProgressHandler((String text, int start, int end, String word) {
      setState(() {
        highlightStart = start;
        highlightEnd = end;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HighlightedText(
          text: widget.textToSpeak,
          highlightEnd: highlightEnd,
          highlightStart: highlightStart,
          decoration: const HighlightDecoration(color: Colors.yellow),
        ),
      ],
    );
  }

  bool get isPaused => _isPaused;
  bool _isPaused = false;

  void speakText() => flutterTts.speak(widget.textToSpeak);

  void resume() {
    // TODO: Implement resume
    speakText();
    _isPaused = false;
  }

  void pause() {
    flutterTts.pause();
    _isPaused = true;
  }

  void stop() => flutterTts.stop();
}
