import 'package:flutter/material.dart';
import 'package:speech_highlighter/speech_highlighter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<SpeechHighlighterState> highlighterKey = GlobalKey<SpeechHighlighterState>();
  final ttsInput =
      'This approach should work better with line breaks and be more reliable in various text scenarios. It also maintains the smooth animation when the highlight changes. If you\'re still experiencing any issues or if you need further modifications, please let me know, and I\'ll be happy to help adjust the code further.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SpeechHighlighter(
              key: highlighterKey,
              textToSpeak: ttsInput,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: speakText,
                  child: const Text('Speak Text'),
                ),
                ElevatedButton(
                  onPressed: () {
                    highlighterKey.currentState?.pause();
                  },
                  child: const Text('Pause'),
                ),
                ElevatedButton(
                  onPressed: () {
                    highlighterKey.currentState?.stop();
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void speakText() {
    highlighterKey.currentState?.speakText();
  }
}
