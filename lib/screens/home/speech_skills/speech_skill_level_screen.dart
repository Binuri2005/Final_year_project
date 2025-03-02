import 'package:app/viewmodels/speech_skills/speech_skill_cards_screen.dart';
import 'package:app/viewmodels/speech_skills/speech_skill_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SpeechSkillLevelScreen extends StatefulWidget {
  const SpeechSkillLevelScreen({super.key});

  @override
  State<SpeechSkillLevelScreen> createState() => _SpeechSkillLevelScreenState();
}

class _SpeechSkillLevelScreenState extends State<SpeechSkillLevelScreen> {
  @override
  void initState() {
    context.read<SpeechSkillViewModel>().getSpeechSkill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        title: Text('Speech Skills'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<SpeechSkillViewModel>(
          builder: (BuildContext context, SpeechSkillViewModel value,
              Widget? child) {
            if (value.isSpeechSkillLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (value.isSpeechSkillError) {
              return Text(
                value.speechSkillErrorMessage,
                style: TextStyle(color: Colors.red),
              );
            }
            return ListView(
              children: value.speechSkillLevels.map((level) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        level.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(level.description),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SpeechSkillCards(
                                        level: level,
                                      )));
                        },
                        child: const Text('Start'),
                      ),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
