// datastructure_level01.dart
List<Map<String, String>> expressionDataList = [
  {"image": "assets/level_01/bored.png", "term": "Bored"},
  {"image": "assets/level_01/nervous.png", "term": "Nervous"},
  {"image": "assets/level_01/surprised.png", "term": "Surprised"},
  {"image": "assets/level_01/angry.png", "term": "Angry"},
  {"image": "assets/level_01/shocked.png", "term": "Shocked"},
  {"image": "assets/level_01/disgust.png", "term": "Disgusted"},
  {"image": "assets/level_01/happy.png", "term": "Happy"},
  {"image": "assets/level_01/sad.png", "term": "Sad"},
  {"image": "assets/level_01/scared.png", "term": "Scared"},
  {"image": "assets/level_01/confused.png", "term": "Confused"},
  {"image": "assets/level_01/excited.png", "term": "Excited"},
  {"image": "assets/level_01/frustrated.png", "term": "Frustrated"},
  {"image": "assets/level_01/tired.png", "term": "Tired"},
  {"image": "assets/level_01/shy.png", "term": "Shy"},
  {"image": "assets/level_01/proud.png", "term": "Proud"},
  {"image": "assets/level_01/lonely.png", "term": "Lonely"},
  {"image": "assets/level_01/worried.png", "term": "Worried"},
  {"image": "assets/level_01/sleepy.png", "term": "Sleepy"},
];

List<Map<String, String>> scenarioToTerm = [
  {"scenario": "You receive a surprise gift.", "term": "Happy"},
  {"scenario": "You hear your favorite song.", "term": "Excited"},
  {"scenario": "You get to play a game you love.", "term": "Happy"},
  {"scenario": "Your team wins a big competition.", "term": "Proud"},
  {
    "scenario": "You see a friend you haven't seen in a long time.",
    "term": "Happy"
  },
  {"scenario": "You finish a big task and it turns out well.", "term": "Proud"},
  {"scenario": "Your balloon flies away.", "term": "Sad"},
  {"scenario": "You are left out of a game.", "term": "Lonely"},
  {"scenario": "You don't get invited to a party.", "term": "Sad"},
  {"scenario": "You break your favorite toy.", "term": "Sad"},
  {
    "scenario": "You have to stay inside when you wanted to go out.",
    "term": "Disappointed"
  },
  {
    "scenario": "You wait for someone, but they don't come.",
    "term": "Disappointed"
  },
  {"scenario": "Someone takes your things without asking.", "term": "Angry"},
  {
    "scenario": "You try to build something, but it keeps falling apart.",
    "term": "Frustrated"
  },
  {"scenario": "Someone says something mean to you.", "term": "Angry"},
  {"scenario": "You can't find something you need.", "term": "Frustrated"},
  {
    "scenario": "You are told you cannot do something you really want to do.",
    "term": "Angry"
  },
  {
    "scenario": "Someone blames you for something you did not do.",
    "term": "Frustrated"
  },
  {"scenario": "You hear a loud, unexpected noise.", "term": "Scared"},
  {"scenario": "You are in a dark room alone.", "term": "Scared"},
  {
    "scenario": "You have a test tomorrow that you didn't study for.",
    "term": "Worried"
  },
  {"scenario": "Your parent is late coming home.", "term": "Worried"},
  {"scenario": "You see a spider or insect that scares you.", "term": "Scared"},
  {
    "scenario": "You have to speak in front of a lot of people.",
    "term": "Worried"
  },
  {"scenario": "You try a new food that tastes strange.", "term": "Disgusted"},
  {
    "scenario": "You don't understand what someone is saying.",
    "term": "Confused"
  },
  {
    "scenario": "You see someone doing something very kind.",
    "term": "Thankful"
  },
  {
    "scenario": "You have nothing to do and no one to play with.",
    "term": "Bored"
  },
  {"scenario": "You see someone get hurt.", "term": "Worried"},
];

//level 3
List<Map<String, String>> scenarioToImage = [
  {
    "scenario": "You receive a surprise gift.",
    "image": "assets/level_01/happy.png"
  },
  {
    "scenario": "You hear your favorite song.",
    "image": "assets/level_01/excited.png"
  },
  {
    "scenario": "You get to play a game you love.",
    "image": "assets/level_01/happy.png"
  },
  {
    "scenario": "Your team wins a big competition.",
    "image": "assets/level_01/proud.png"
  },
  {
    "scenario": "You see a friend you haven't seen in a long time.",
    "image": "assets/level_01/happy.png"
  },
  {
    "scenario": "You finish a big task and it turns out well.",
    "image": "assets/level_01/proud.png"
  },
  {"scenario": "Your balloon flies away.", "image": "assets/level_01/sad.png"},
  {
    "scenario": "You are left out of a game.",
    "image": "assets/level_01/lonely.png"
  },
  {
    "scenario": "You don't get invited to a party.",
    "image": "assets/level_01/sad.png"
  },
  {
    "scenario": "You break your favorite toy.",
    "image": "assets/level_01/sad.png"
  },
  {
    "scenario": "You have to stay inside when you wanted to go out.",
    "image": ""
  },
  {"scenario": "You wait for someone, but they don't come.", "image": ""},
  {
    "scenario": "Someone takes your things without asking.",
    "image": "assets/level_01/angry.png"
  },
  {
    "scenario": "You try to build something, but it keeps falling apart.",
    "image": "assets/level_01/frustrated.png"
  },
  {
    "scenario": "Someone says something mean to you.",
    "image": "assets/level_01/angry.png"
  },
  {
    "scenario": "You can't find something you need.",
    "image": "assets/level_01/frustrated.png"
  },
  {
    "scenario": "You are told you cannot do something you really want to do.",
    "image": "assets/level_01/angry.png"
  },
  {
    "scenario": "Someone blames you for something you did not do.",
    "image": "assets/level_01/frustrated.png"
  },
  {
    "scenario": "You hear a loud, unexpected noise.",
    "image": "assets/level_01/scared.png"
  },
  {
    "scenario": "You are in a dark room alone.",
    "image": "assets/level_01/scared.png"
  },
  {
    "scenario": "You have a test tomorrow that you didn't study for.",
    "image": "assets/level_01/worried.png"
  },
  {
    "scenario": "Your parent is late coming home.",
    "image": "assets/level_01/worried.png"
  },
  {
    "scenario": "You see a spider or insect that scares you.",
    "image": "assets/level_01/scared.png"
  },
  {
    "scenario": "You have to speak in front of a lot of people.",
    "image": "assets/level_01/worried.png"
  },
  {
    "scenario": "You try a new food that tastes strange.",
    "image": "assets/level_01/disgust.png"
  },
  {
    "scenario": "You don't understand what someone is saying.",
    "image": "assets/level_01/confused.png"
  },
  {"scenario": "You see someone doing something very kind.", "image": ""},
  {
    "scenario": "You have nothing to do and no one to play with.",
    "image": "assets/level_01/bored.png"
  },
  {
    "scenario": "You see someone get hurt.",
    "image": "assets/level_01/worried.png"
  },
];
