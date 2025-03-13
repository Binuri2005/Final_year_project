class ApiConstants {
  static const String BASE_URL = 'http://localhost:3000';

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';

  static const String getUser = '/user';

  static const String getUserAnalytics = '/user/analytics';

  static const String getSocialSkillQuizzes = '/quiz/all';

  static const String getAllSpeechSkills = '/speech-skills';

  static const String verifyOtp = '/auth/verify-otp';

  static String createChallenge = '/daily-life/create';

  static String getDailySkills = '/daily-life';

  static String markStepAsComplete = '/speech-skills/submit';

  static String submitDailySkill = '/daily-life/submit';

  static String submitSocialSkillRound = '/quiz/answer';
}
