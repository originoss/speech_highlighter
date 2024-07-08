class SpeechConfig {
  final double volume;
  final double pitch;
  final double speechRate;
  final String languageCode;

  const SpeechConfig({
    this.volume = 1.0,
    this.pitch = 1.0,
    this.speechRate = 0.2,
    this.languageCode = 'en-US',
  });
}
