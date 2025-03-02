class SpeechSkillLevel {
  final String id;
  final String name;

  final String description;

  final List<SpeechSkillSentence> sentences;

  factory SpeechSkillLevel.fromJson(Map<String, dynamic> json) {
    return SpeechSkillLevel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sentences: json['PracticeSentence']
          .map<SpeechSkillSentence>(
              (sentence) => SpeechSkillSentence.fromJson(sentence))
          .toList(),
    );
  }

  SpeechSkillLevel(
      {required this.id,
      required this.name,
      required this.description,
      required this.sentences});
}

class SpeechSkillSentence {
  final String id;
  final String sentence;
  final String difficulty;

  final DateTime createdAt;

  SpeechSkillSentence(
      {required this.id,
      required this.sentence,
      required this.difficulty,
      required this.createdAt});

  factory SpeechSkillSentence.fromJson(Map<String, dynamic> json) {
    return SpeechSkillSentence(
      id: json['id'],
      sentence: json['sentence'],
      difficulty: json['difficulty'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
