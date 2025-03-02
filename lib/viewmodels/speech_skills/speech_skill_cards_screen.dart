import 'package:app/models/speech_skills/speech_skill_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../services/tts/tts.service.dart';

class SpeechSkillCards extends StatefulWidget {
  // FOR NOW

  final SpeechSkillLevel level;
  const SpeechSkillCards({super.key, required this.level});

  @override
  State<SpeechSkillCards> createState() => _SpeechSkillCardsState();
}

enum SpeechSpeed { slower, slow, normal, fast, faster }

Color getColor(SpeechSpeed speed) {
  switch (speed) {
    case SpeechSpeed.slower:
      return Colors.black54;
    case SpeechSpeed.slow:
      return Colors.brown;
    case SpeechSpeed.normal:
      return Colors.green;
    case SpeechSpeed.fast:
      return Colors.pink;
    case SpeechSpeed.faster:
      return Colors.red;
  }
}

class _SpeechSkillCardsState extends State<SpeechSkillCards> {
  List<Widget> cards = [];

  @override
  void initState() {
    cards = widget.level.sentences
        .map((e) => SkillSentence(
              sentence: e,
            ))
        .toList();
    super.initState();
  }

  SpeechSpeed speed = SpeechSpeed.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Center(
                  child: CardSwiper(
                    cardsCount: cards.length,
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        Center(child: cards[index]),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: SpeechSpeed.values
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                speed = e;
                              });
                              switch (e) {
                                case SpeechSpeed.slow:
                                  TTSService().setSpeed(25 / 100);
                                  break;
                                case SpeechSpeed.slower:
                                  TTSService().setSpeed(15 / 100);
                                  break;
                                case SpeechSpeed.normal:
                                  TTSService().setSpeed(50 / 100);
                                  break;
                                case SpeechSpeed.fast:
                                  TTSService().setSpeed(60 / 100);
                                  break;
                                case SpeechSpeed.faster:
                                  TTSService().setSpeed(65 / 100);
                                  break;
                              }
                            },
                            child: InkWell(
                              child: AnimatedContainer(
                                padding: const EdgeInsets.all(10),
                                duration: Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: e == speed
                                      ? getColor(e).withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      e.name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: e == speed ? 15 : 13,
                                        fontWeight: e == speed
                                            ? FontWeight.w800
                                            : FontWeight.w400,
                                        color: e == speed
                                            ? getColor(e)
                                            : Colors.black54.withOpacity(1),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Icon(
                                      e == speed
                                          ? Iconsax.tick_circle_bold
                                          : Iconsax.close_square_bold,
                                      size: e == speed ? 30 : 20,
                                      color: e == speed
                                          ? getColor(e)
                                          : Colors.grey.withOpacity(0.2),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList()),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillSentence extends StatefulWidget {
  final SpeechSkillSentence sentence;
  const SkillSentence({super.key, required this.sentence});

  @override
  State<SkillSentence> createState() => _SkillSentenceState();
}

class _SkillSentenceState extends State<SkillSentence> {
  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.sentence.difficulty,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.pink,
              )),
          SizedBox(height: 5),
          Text(
            "'${widget.sentence.sentence}'",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          SizedBox(
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  _isSpeaking = true;
                });
                await TTSService().speak(widget.sentence.sentence);

                setState(() {
                  _isSpeaking = false;
                });
              },
              child: CircleAvatar(
                backgroundColor: _isSpeaking ? Colors.pink : Colors.black,
                radius: 30,
                child: Icon(
                  _isSpeaking ? Iconsax.pause_bold : Iconsax.microphone_2_bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
