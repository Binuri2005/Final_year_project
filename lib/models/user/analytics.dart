class UserAnalytics {
  final List<SpeechSkillResult> speechSkillResults;
  final List<DailyLifeResult> dailyLifeResults;
  final List<SocialSkillResult> socialSkillResults;

  UserAnalytics({
    required this.speechSkillResults,
    required this.dailyLifeResults,
    required this.socialSkillResults,
  });

  factory UserAnalytics.fromJson(Map<String, dynamic> json) {
    return UserAnalytics(
      speechSkillResults: (json['speechSkillResults'] as List<dynamic>)
          .map((item) => SpeechSkillResult.fromJson(item))
          .toList(),
      dailyLifeResults: (json['dailyLifeResults'] as List<dynamic>)
          .map((item) => DailyLifeResult.fromJson(item))
          .toList(),
      socialSkillResults: (json['socialSkillResults'] as List<dynamic>)
          .map((item) => SocialSkillResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speechSkillResults':
          speechSkillResults.map((item) => item.toJson()).toList(),
      'dailyLifeResults':
          dailyLifeResults.map((item) => item.toJson()).toList(),
      'socialSkillResults':
          socialSkillResults.map((item) => item.toJson()).toList(),
    };
  }
}

class SpeechSkillResult {
  final String id;
  final DateTime createdAt;
  final SkillLevel speechSkillLevel;

  SpeechSkillResult({
    required this.id,
    required this.createdAt,
    required this.speechSkillLevel,
  });

  factory SpeechSkillResult.fromJson(Map<String, dynamic> json) {
    return SpeechSkillResult(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      speechSkillLevel: SkillLevel.fromJson(json['speechSkillLevel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'speechSkillLevel': speechSkillLevel.toJson(),
    };
  }
}

class DailyLifeResult {
  final String id;
  final DateTime completedAt;
  final Challenge challenge;

  DailyLifeResult({
    required this.id,
    required this.completedAt,
    required this.challenge,
  });

  factory DailyLifeResult.fromJson(Map<String, dynamic> json) {
    return DailyLifeResult(
      id: json['id'],
      completedAt: DateTime.parse(json['completedAt']),
      challenge: Challenge.fromJson(json['challenge']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completedAt': completedAt.toIso8601String(),
      'challenge': challenge.toJson(),
    };
  }
}

class Challenge {
  final String id;
  final String title;

  Challenge({
    required this.id,
    required this.title,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class SocialSkillResult {
  final String id;
  final DateTime createdAt;
  final LevelRound levelRound;

  SocialSkillResult({
    required this.id,
    required this.createdAt,
    required this.levelRound,
  });

  factory SocialSkillResult.fromJson(Map<String, dynamic> json) {
    return SocialSkillResult(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      levelRound: LevelRound.fromJson(json['levelRound']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'levelRound': levelRound.toJson(),
    };
  }
}

class LevelRound {
  final String id;
  final int round;
  final SkillLevel level;

  LevelRound({
    required this.id,
    required this.round,
    required this.level,
  });

  factory LevelRound.fromJson(Map<String, dynamic> json) {
    return LevelRound(
      id: json['id'],
      round: json['round'],
      level: SkillLevel.fromJson(json['level']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'round': round,
      'level': level.toJson(),
    };
  }
}

class SkillLevel {
  final String id;
  final String name;

  SkillLevel({
    required this.id,
    required this.name,
  });

  factory SkillLevel.fromJson(Map<String, dynamic> json) {
    return SkillLevel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
