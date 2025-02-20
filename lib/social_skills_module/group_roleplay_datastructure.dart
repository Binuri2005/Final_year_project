final Map<String, Map<String, dynamic>> groupScenarioDetails = {
  '1. Planning a Party': {
    'description': 'Organize and plan a party for a group of friends.',
    'steps': [
      'Plan the party theme',
      'Set up a party budget',
      'Create a guest list',
      'Decorate the venue',
      'Prepare a playlist and food menu',
    ],
    'image': 'assets/images/greeting_A_friend.png',
    'roles': [
      'Planner:Organizes the party',
      'Friend: Helps with ideas and tasks.',
      'Guest:Attends the party.',
      'Decorator:Handles party decorations.'
    ],
    'dialogues': {
      'Planner': [
        "Let’s pick a theme for the party!",
        "I’ll send out invitations today.",
        "Can you help me set up the decorations?",
        "I’m so excited, it’s almost time!",
        "Thank you all for helping me plan this party!",
      ],
      'Friend': [
        "How about a beach theme?",
        "I’ll help with the snacks!",
        "I’ll bring the music playlist.",
        "Let’s make this the best party ever!",
        "What else do we need to do?",
      ],
      'Guest': [
        "I’m so excited for the party!",
        "This place looks amazing!",
        "Thank you for inviting me!",
        "Can I help with anything?",
        "This is so much fun!",
      ],
      'Decorator': [
        "I’ve got the balloons ready.",
        "The decorations are up! It’s looking great!",
        "Where should I put the streamers?",
        "I’ll make sure everything looks perfect.",
        "The party space is ready!",
      ],
    },
  },
  '2. Shopping at a Grocery Store': {
    'description': 'Go shopping for groceries with a list of items to buy.',
    'steps': [
      'Prepare a shopping list',
      'Select the items from shelves',
      'Pay at the checkout',
      'Pack the groceries',
    ],
    'image': 'assets/images/grocery_store.png',
    'roles': ['Shopper', 'Cashier', 'Store Assistant', 'Friend'],
    'dialogues': {
      'Shopper': [
        "Do you have any tomatoes?",
        "I’ll grab some milk and bread.",
        "Can you help me find the eggs?",
        "How much does this cost?",
        "Thank you for your help!",
      ],
      'Cashier': [
        "Hello! Do you have a shopping list?",
        "Your total is 15.50.",
        "Would you like paper or plastic bags?",
        "Here’s your receipt.",
        "Have a great day!",
      ],
      'Store Assistant': [
        "The tomatoes are in aisle 3.",
        "Let me show you where the eggs are.",
        "We have fresh apples today.",
        "Do you need help with anything else?",
        "The milk is on sale today!",
      ],
      'Friend': [
        "I’ll get the chips if you grab the drinks.",
        "This looks like a great deal!",
        "Let’s check the price of this cereal.",
        "Do we need anything else from this aisle?",
        "This is fun! Let’s shop together again.",
      ],
    },
  },
  // Add the remaining scenarios in the same format...
};
