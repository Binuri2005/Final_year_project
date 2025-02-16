Map<String, Map<String, dynamic>> scenarioDetails = {
  // 1. Planning a Party
  'Planning a Party': {
    'description': 'Practice discussing themes, choosing decorations, and planning a party event.',
    'steps': [
      "1. The Planner decides on a party theme.",
      "2. The Planner asks for ideas from Friends and assigns tasks.",
      "3. The Decorator sets up decorations.",
      "4. The Planner sends out invitations.",
      "5. The Planner and Friends prepare for the party.",
      "6. Guests arrive and enjoy the party."
    ],
    'roles': ['Planner', 'Friend', 'Guest', 'Decorator'],
    'dialogues': {
      'Planner': [
        "Let’s pick a theme for the party!",
        "I’ll send out invitations today.",
        "Can you help me set up the decorations?",
        "I’m so excited, it’s almost time!"
      ],
      'Friend': [
        "How about a beach theme?",
        "I’ll help with the snacks!",
        "I’ll bring the music playlist."
      ],
      'Guest': [
        "I’m so excited for the party!",
        "This place looks amazing!"
      ],
      'Decorator': [
        "I’ve got the balloons ready.",
        "The decorations are up! It’s looking great!"
      ]
    },
    'image': 'assets/images/party_planning.png'
  },

  // 2. Shopping at a Grocery Store
  'Shopping at a Grocery Store': {
    'description': 'Practice shopping for food items, comparing prices, and interacting with store staff.',
    'steps': [
      "1. The Shopper makes a list of needed items.",
      "2. The Shopper and Friend walk through the aisles, finding products.",
      "3. The Shopper talks to the Store Assistant if something is needed.",
      "4. The Shopper proceeds to the checkout counter.",
      "5. The Cashier scans the items and the Shopper pays."
    ],
    'roles': ['Shopper', 'Cashier', 'Store Assistant', 'Friend'],
    'dialogues': {
      'Shopper': [
        "Do you have any tomatoes?",
        "I’ll grab some milk and bread.",
        "Can you help me find the eggs?"
      ],
      'Cashier': [
        "Your total is 15.50 dollors.",
        "Would you like paper or plastic bags?"
      ],
      'Store Assistant': [
        "The tomatoes are in aisle 3.",
        "Let me show you where the eggs are."
      ],
      'Friend': [
        "I’ll get the chips if you grab the drinks.",
        "This looks like a great deal!"
      ]
    },
    'image': 'assets/images/grocery_store.png'
  },

  // 3. Cleaning Up as a Team
  'Cleaning Up as a Team': {
    'description': 'Practice working together to clean up a space, delegating tasks, and supporting each other.',
    'steps': [
      "1. The Team Leader assigns cleaning tasks to everyone.",
      "2. Everyone starts cleaning the room according to the tasks.",
      "3. The Trash Collector gathers trash and disposes of it.",
      "4. The Sweeper sweeps the floor and mops.",
      "5. The Team Leader inspects the space and ensures it’s clean."
    ],
    'roles': ['Team Leader', 'Cleaner', 'Sweeper', 'Trash Collector'],
    'dialogues': {
      'Team Leader': [
        "Let’s all split the cleaning tasks.",
        "Who’s ready to sweep the floor?"
      ],
      'Cleaner': [
        "I’ll wipe down the tables.",
        "I’m done with the windows!"
      ],
      'Sweeper': [
        "I’m starting on the floor now.",
        "I’ll finish up with the mop."
      ],
      'Trash Collector': [
        "I’ll take out the garbage.",
        "All the trash is gone."
      ]
    },
    'image': 'assets/images/cleaning_team.png'
  },

  // 4. Storytelling Circle
  'Storytelling Circle': {
    'description': 'Practice telling stories in a group, adding creative elements, and listening to others.',
    'steps': [
      "1. The Storyteller begins with an opening line.",
      "2. The Listener adds to the story with their ideas.",
      "3. The Commentator suggests twists or turns in the plot.",
      "4. The Observer enjoys the story and reflects on it.",
      "5. The circle continues as each person contributes."
    ],
    'roles': ['Storyteller', 'Listener', 'Commentator', 'Observer'],
    'dialogues': {
      'Storyteller': [
        "Once upon a time, there was a dragon.",
        "The dragon flew across the sky, looking for treasure."
      ],
      'Listener': [
        "I think the dragon should meet a wizard."
      ],
      'Commentator': [
        "What if the dragon gets lost in a dark forest?"
      ],
      'Observer': [
        "This is a fun story! Keep going."
      ]
    },
    'image': 'assets/images/storytelling_circle.png'
  },

  // 5. Group Project
  'Group Project': {
    'description': 'Practice collaborating with others on a group project, sharing ideas, and presenting results.',
    'steps': [
      "1. The Leader assigns tasks to each group member.",
      "2. The Researcher collects information needed for the project.",
      "3. The Designer creates visual content for the project.",
      "4. The group collaborates to put everything together.",
      "5. The Presenter shares the project with others."
    ],
    'roles': ['Leader', 'Researcher', 'Designer', 'Presenter'],
    'dialogues': {
      'Leader': [
        "Let’s make sure we all understand our tasks.",
        "We need to finish by the end of the week."
      ],
      'Researcher': [
        "I found some useful sources for our topic."
      ],
      'Designer': [
        "I’ll start designing the slides."
      ],
      'Presenter': [
        "I’ll present our findings to the class."
      ]
    },
    'image': 'assets/images/group_project.png'
  },

  // 6. Playing at the Park
  'Playing at the Park': {
    'description': 'Practice playing games, taking turns, and sharing space with others.',
    'steps': [
      "1. The Player and Friends decide on a game to play.",
      "2. The Referee explains the rules.",
      "3. Everyone takes turns and plays.",
      "4. The Spectator cheers and supports.",
      "5. The game ends and everyone congratulates each other."
    ],
    'roles': ['Player', 'Referee', 'Spectator', 'Friend'],
    'dialogues': {
      'Player': [
        "Let’s play soccer!",
        "I’m going to try to score a goal!"
      ],
      'Referee': [
        "No touching the ball with hands, remember!"
      ],
      'Spectator': [
        "Go, go, go! You can do it!"
      ],
      'Friend': [
        "Let’s play again, that was so fun!"
      ]
    },
    'image': 'assets/images/park_play.png'
  },

  // 7. Going to a Restaurant (Already Provided)

  // 8. Visiting a Doctor
  'Visiting a Doctor': {
    'description': 'Practice discussing symptoms, asking questions, and following medical advice.',
    'steps': [
      "1. The Patient describes their symptoms.",
      "2. The Doctor asks questions and gives advice.",
      "3. The Nurse takes measurements (like height, weight).",
      "4. The Patient listens to the Doctor’s recommendations.",
      "5. The Patient leaves with a follow-up plan."
    ],
    'roles': ['Patient', 'Doctor', 'Nurse', 'Friend'],
    'dialogues': {
      'Patient': [
        "I’ve been feeling tired lately.",
        "Do I need to take any medicine?"
      ],
      'Doctor': [
        "Let’s check your blood pressure.",
        "You should rest more and stay hydrated."
      ],
      'Nurse': [
        "Please step on the scale for your weight."
      ],
      'Friend': [
        "I hope everything is okay!"
      ]
    },
    'image': 'assets/images/doctor_visit.png'
  },

  // 9. Attending a Birthday Party
  'Attending a Birthday Party': {
    'description': 'Practice wishing someone happy birthday, giving gifts, and interacting with guests.',
    'steps': [
      "1. The Host prepares for the party.",
      "2. The Birthday Person receives guests.",
      "3. Guests give gifts and wish the Birthday Person well.",
      "4. The group sings happy birthday and enjoys cake.",
      "5. The Birthday Person thanks everyone for coming."
    ],
    'roles': ['Birthday Person', 'Guest', 'Host', 'Friend'],
    'dialogues': {
      'Birthday Person': [
        "Thank you for the gift!",
        "I’m so happy you all could come!"
      ],
      'Guest': [
        "Happy birthday! I hope you have a wonderful year!"
      ],
      'Host': [
        "I’m so glad you could make it!"
      ],
      'Friend': [
        "This cake looks amazing, let’s eat!"
      ]
    },
    'image': 'assets/images/birthday_party.png'
  },

  // 10. Classroom Experience
  'Classroom Experience': {
    'description': 'Practice participating in class discussions, asking questions, and following classroom rules.',
    'steps': [
      "1. The Teacher starts the lesson.",
      "2. The Student listens and takes notes.",
      "3. The Classmate helps with questions.",
      "4. The Student asks for clarification if needed.",
      "5. The Teacher concludes the class."
    ],
    'roles': ['Student', 'Teacher', 'Classmate', 'Class Monitor'],
    'dialogues': {
      'Student': [
        "Can you explain that again?",
        "I have a question about the homework."
      ],
      'Teacher': [
        "Let me explain that in more detail.",
        "Please remember to hand in your assignments."
      ],
      'Classmate': [
        "I can help you with the notes."
      ],
      'Class Monitor': [
        "Please line up for the next class."
      ]
    },
    'image': 'assets/images/classroom.png'
  }
};
