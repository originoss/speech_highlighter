import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_highlighter/speech_highlighter.dart';

/// Speech Highlighter allows you to highlight words in a text based
/// on the current text to speech reader state and progress.
/// It uses [flutter_tts](https://pub.dev/packages/flutter_tts) to speak
///
/// ```dart
/// SpeechHighlighter(
///   textToSpeak: 'Hello World',
///   decoration: HighlightDecoration(
///     color: Colors.red,
///     borderRadius: Radius.circular(5),
///   ),
/// ),
/// ```
class SpeechHighlighter extends StatefulWidget {
  /// Text to be highlighted.
  /// It will be spoken when the text to speak runs.
  final String textToSpeak;

  /// Configuration for the text to speech reader
  /// It allows you to set the language, speech rate, volume, and pitch.
  ///
  /// ```dart
  /// SpeechConfig(
  ///   languageCode: 'en-US',
  ///   speechRate: 1.0,
  ///   volume: 1.0,
  ///   pitch: 1.0,
  /// )
  /// ```
  final SpeechConfig config;

  /// Decoration for the highlighted text
  ///
  /// Defaults to [HighlightDecoration]
  /// ```dart
  /// HighlightDecoration(
  ///   color: Colors.red,
  ///   borderRadius: Radius.circular(5),
  /// )
  /// ```
  final HighlightDecoration decoration;

  /// Style for the text to be highlighted
  final TextStyle textStyle;

  /// Duration of the animation when switching between highlights
  ///
  /// Defaults to [Duration(milliseconds: 300)]
  final Duration animationDuration;

  /// Curve of the animation when switching between highlights
  ///
  /// Defaults to [Curves.elasticOut]
  final Curve curve;

  const SpeechHighlighter({
    super.key,
    required this.textToSpeak,
    this.decoration = const HighlightDecoration(
      color: Colors.red,
      borderRadius: Radius.circular(5),
    ),
    this.config = const SpeechConfig(),
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.elasticOut,
  });

  @override
  State<SpeechHighlighter> createState() => SpeechHighlighterState();
}

class SpeechHighlighterState extends State<SpeechHighlighter> {
  final FlutterTts _flutterTts = FlutterTts();

  int highlightStart = 0;
  int highlightEnd = 0;

  @override
  void initState() {
    super.initState();
    _initTTS();
  }

  void _initTTS() async {
    _flutterTts.setLanguage(widget.config.languageCode);
    _flutterTts.setSpeechRate(widget.config.speechRate);
    _flutterTts.setVolume(widget.config.volume);
    _flutterTts.setPitch(widget.config.pitch);

    _flutterTts.setProgressHandler((String text, int start, int end, String word) {
      setState(() {
        highlightStart = start;
        highlightEnd = end;
      });
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
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
          decoration: widget.decoration,
          textStyle: widget.textStyle,
          animationDuration: widget.animationDuration,
        ),
      ],
    );
  }

  bool get isPaused => _isPaused;
  bool _isPaused = false;

  /// Starts the text to speech reader
  ///
  /// ```dart
  /// highlighterKey.currentState?.speakText();
  /// ```
  void speakText() => _flutterTts.speak(widget.textToSpeak);

  /// Pauses the text to speech reader
  ///
  /// ```dart
  /// highlighterKey.currentState?.pause();
  /// ```
  void resume() {
    // TODO: Implement resume
    speakText();
    _isPaused = false;
  }

  /// Stops the text to speech reader
  ///
  /// ```dart
  /// highlighterKey.currentState?.stop();
  /// ```
  void pause() {
    _flutterTts.pause();
    _isPaused = true;
  }

  /// Stops the text to speech reader
  ///
  /// ```dart
  /// highlighterKey.currentState?.stop();
  /// ```
  void stop() => _flutterTts.stop();
}
