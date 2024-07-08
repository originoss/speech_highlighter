# Speech Highlighter

![demo](./demo.gif)

TODO: Write docs

### Usage

```dart
final GlobalKey<SpeechHighlighterState> highlighterKey = GlobalKey<SpeechHighlighterState>();
final ttsInput = 'This is a test text to be highlighted. We are making it long so that it will wrap.';
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SpeechHighlighter(
            key: highlighterKey,
            textToSpeak: ttsInput,
            decoration: const HighlightDecoration(
              color: Colors.red,
              borderRadius: Radius.circular(5),
            ),
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
    );
  }

  void speakText() {
    highlighterKey.currentState?.speakText();
  }
```