# Speech Highlighter

TODO: Write docs

### Usage

```dart
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
```