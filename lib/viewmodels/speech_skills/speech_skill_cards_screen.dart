import 'package:app/models/speech_skills/speech_skill_level.dart';
import 'package:app/viewmodels/speech_skills/speech_skill_viewmodel.dart';
import 'package:app/viewmodels/user/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../services/tts/tts.service.dart';

class SpeechSkillCards extends StatefulWidget {
  final SpeechSkillLevel level;
  const SpeechSkillCards({super.key, required this.level});

  @override
  State<SpeechSkillCards> createState() => _SpeechSkillCardsState();
}

enum SpeechSpeed { slower, slow, normal, fast, faster }

Color getColor(SpeechSpeed speed) {
  switch (speed) {
    case SpeechSpeed.slower:
      return Colors.blue.shade800;
    case SpeechSpeed.slow:
      return Colors.teal;
    case SpeechSpeed.normal:
      return Colors.green;
    case SpeechSpeed.fast:
      return Colors.orange;
    case SpeechSpeed.faster:
      return Colors.red;
  }
}

class _SpeechSkillCardsState extends State<SpeechSkillCards> {
  final CardSwiperController _swiperController = CardSwiperController();
  List<Widget> cards = [];
  SpeechSpeed speed = SpeechSpeed.normal;
  int currentCardIndex = 0;
  Set<int> viewedCards = {};

  @override
  void initState() {
    cards = widget.level.sentences
        .map((e) => SkillSentence(
              sentence: e,
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.level.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "${viewedCards.length}/${cards.length}",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade100],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LinearProgressIndicator(
                  value: cards.isEmpty ? 0 : viewedCards.length / cards.length,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(getColor(speed)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                flex: 5,
                child: Center(
                  child: CardSwiper(
                    controller: _swiperController,
                    cardsCount: cards.length,
                    onSwipe: (index, c, d) async {
                      setState(() {
                        currentCardIndex = c ?? 0;
                        viewedCards.add(index);
                      });

                      // Check if all cards have been viewed
                      if (viewedCards.length >= cards.length) {
                        context.read<SpeechSkillViewModel>().markStepAsComplete(
                          widget.level.id,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'You have completed this skill!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop();

                            context.read<UserViewModel>().getUser();
                          },
                        );
                        return false;
                      }
                      return true;
                    },
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        Center(child: cards[index]),
                    scale: 0.9,
                    padding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "SPEECH SPEED",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: SpeechSpeed.values
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
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
                                  child: AnimatedContainer(
                                    width: 58,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: e == speed
                                          ? getColor(e).withOpacity(0.15)
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: e == speed
                                            ? getColor(e)
                                            : Colors.grey.shade300,
                                        width: e == speed ? 2 : 1,
                                      ),
                                      boxShadow: e == speed
                                          ? [
                                              BoxShadow(
                                                color: getColor(e)
                                                    .withOpacity(0.2),
                                                blurRadius: 10,
                                                spreadRadius: 1,
                                              )
                                            ]
                                          : [],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          e == SpeechSpeed.slower
                                              ? Iconsax.backward_bold
                                              : e == SpeechSpeed.slow
                                                  ? Iconsax.previous_bold
                                                  : e == SpeechSpeed.normal
                                                      ? Iconsax.play_bold
                                                      : e == SpeechSpeed.fast
                                                          ? Iconsax.next_bold
                                                          : Iconsax
                                                              .forward_bold,
                                          size: e == speed ? 24 : 20,
                                          color: e == speed
                                              ? getColor(e)
                                              : Colors.grey.shade600,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          e.name[0].toUpperCase() +
                                              e.name.substring(1),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: e == speed
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: e == speed
                                                ? getColor(e)
                                                : Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigationButton(
                      icon: Iconsax.previous_bold,
                      onTap: () {
                        _swiperController.swipe(CardSwiperDirection.left);
                      },
                    ),
                    NavigationButton(
                      icon: Iconsax.repeat_bold,
                      onTap: () {
                        if (cards.isNotEmpty &&
                            currentCardIndex < cards.length) {
                          final skillSentence =
                              widget.level.sentences[currentCardIndex];
                          TTSService().speak(skillSentence.sentence);
                        }
                      },
                      color: getColor(speed),
                      isMain: true,
                    ),
                    NavigationButton(
                      icon: Iconsax.next_bold,
                      onTap: () {
                        _swiperController.swipe(CardSwiperDirection.right);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final bool isMain;

  const NavigationButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color,
    this.isMain = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isMain ? 60 : 50,
        width: isMain ? 60 : 50,
        decoration: BoxDecoration(
          color: isMain ? (color ?? Colors.green) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: (isMain ? (color ?? Colors.green) : Colors.grey)
                  .withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isMain ? Colors.white : Colors.grey.shade700,
          size: isMain ? 28 : 24,
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
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: _getDifficultyColor(widget.sentence.difficulty)
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -20,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: _getDifficultyColor(widget.sentence.difficulty)
                      .withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(widget.sentence.difficulty)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      widget.sentence.difficulty.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getDifficultyColor(widget.sentence.difficulty),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    '"${widget.sentence.sentence}"',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isSpeaking = true;
                      });
                      await TTSService().speak(widget.sentence.sentence);
                      setState(() {
                        _isSpeaking = false;
                      });
                    },
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: _isSpeaking
                            ? _getDifficultyColor(widget.sentence.difficulty)
                            : Colors.black,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isSpeaking
                                    ? _getDifficultyColor(
                                        widget.sentence.difficulty)
                                    : Colors.black)
                                .withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isSpeaking
                            ? Iconsax.pause_bold
                            : Iconsax.microphone_2_bold,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    difficulty = difficulty.toLowerCase();
    if (difficulty.contains('easy')) return Colors.green;
    if (difficulty.contains('medium')) return Colors.orange;
    if (difficulty.contains('hard')) return Colors.red;
    if (difficulty.contains('beginner')) return Colors.blue;
    if (difficulty.contains('advanced')) return Colors.purple;
    return Colors.pink;
  }
}
