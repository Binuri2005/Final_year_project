import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  FlutterTts flutterTts = FlutterTts();

//  singleton
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  setSpeed(double speed) {
    flutterTts.setSpeechRate(speed);
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);

    await flutterTts.speak(text);
  }
}
