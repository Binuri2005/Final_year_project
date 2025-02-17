/* {
          'description': 'Description not available',
          'steps': ['No steps available'],
          'image': '', // Use the image path from the data structure
          'participants': 'N/A',
          'roles': [],
          'dialogues': [],
        };*/

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
    'participants': 'Host, Guest 1, Guest 2, Guest 3',
    'roles': [
      'Host - responsible for planning and organizing',
      'Guest - bringing a gift',
      'Guest - setting up decorations',
    ],
    'dialogues': [
      'Host: "Welcome to the party!"',
      'Guest 1: "I brought a gift for the host!"',
    ],
  },
  '2. Shopping at a Grocery Store': {
    'description': 'Go shopping for groceries with a list of items to buy.',
    'steps': [
      'Prepare a shopping list',
      'Select the items from shelves',
      'Pay at the checkout',
      'Pack the groceries',
    ],
    'image': 'assets/images/grocery_image.png',
    'participants': 'Shopper, Cashier',
    'roles': [
      'Shopper - buying the groceries',
      'Cashier - processing payment and bagging items',
    ],
    'dialogues': [
      'Shopper: "Can you help me find the rice?"',
      'Cashier: "Sure, it’s on aisle 3."',
    ],
  },
  '3. Cleaning Up as a Team': {
    'description':
        'A team of people is tasked with cleaning a large area together.',
    'steps': [
      'Divide tasks among team members',
      'Assign specific cleaning equipment',
      'Set a timer for how long each task will take',
      'Complete the cleaning tasks',
    ],
    'image': 'assets/images/cleaning_image.png',
    'participants': 'Team Leader, Team Member 1, Team Member 2, Team Member 3',
    'roles': [
      'Team Leader - overseeing the cleaning process',
      'Team Member 1 - dusting the shelves',
      'Team Member 2 - vacuuming the floor',
      'Team Member 3 - wiping windows',
    ],
    'dialogues': [
      'Team Leader: "Alright, let’s divide the tasks!"',
      'Team Member 1: "I’ll take care of the shelves."',
    ],
  },
  '4. Storytelling Circle': {
    'description': 'A group of people takes turns telling a story.',
    'steps': [
      'Sit in a circle',
      'Select a theme or prompt for the story',
      'Each person takes a turn adding to the story',
      'End the story when everyone has participated',
    ],
    'image': 'assets/images/storytelling_image.png',
    'participants': 'Storyteller 1, Storyteller 2, Storyteller 3',
    'roles': [
      'Storyteller 1 - starts the story',
      'Storyteller 2 - continues the story',
      'Storyteller 3 - concludes the story',
    ],
    'dialogues': [
      'Storyteller 1: "Once upon a time, in a faraway land..."',
      'Storyteller 2: "Then the dragon appeared!"',
    ],
  },
  '5. Group Project': {
    'description':
        'Collaborate as a group to complete a school or work project.',
    'steps': [
      'Brainstorm ideas for the project',
      'Divide tasks according to skillsets',
      'Work on individual tasks',
      'Review and compile the project together',
    ],
    'image': 'assets/images/group_project_image.png',
    'participants': 'Project Manager, Researcher, Designer, Developer',
    'roles': [
      'Project Manager - overseeing the project timeline',
      'Researcher - gathering relevant information',
      'Designer - creating visuals for the project',
      'Developer - implementing technical aspects of the project',
    ],
    'dialogues': [
      'Project Manager: "Let’s meet up and divide the tasks."',
      'Researcher: "I’ll start with the research section."',
    ],
  },
  '6. Playing at the Park': {
    'description': 'A group of children playing in a park.',
    'steps': [
      'Decide on a game to play',
      'Set up the game area',
      'Play the game while following the rules',
      'Take breaks and stay hydrated',
    ],
    'image': 'assets/images/park_image.png',
    'participants': 'Child 1, Child 2, Child 3',
    'roles': [
      'Child 1 - decides the game rules',
      'Child 2 - follows the game rules',
      'Child 3 - acts as the referee',
    ],
    'dialogues': [
      'Child 1: "Let’s play tag!"',
      'Child 2: "You’re it!"',
    ],
  },
  '7. Going to a Restaurant': {
    'description': 'Dining out at a restaurant and ordering food.',
    'steps': [
      'Choose a restaurant to dine in',
      'Look at the menu and decide on dishes',
      'Place the order with the waiter',
      'Enjoy the meal and pay the bill',
    ],
    'image': 'assets/images/restaurant_image.png',
    'participants': 'Diner, Waiter, Chef',
    'roles': [
      'Diner - orders and enjoys the meal',
      'Waiter - takes the order and serves food',
      'Chef - prepares the dishes',
    ],
    'dialogues': [
      'Diner: "I’ll have the pasta."',
      'Waiter: "Coming right up!"',
    ],
  },
  '8. Visiting a Doctor': {
    'description': 'A visit to the doctor for a check-up or treatment.',
    'steps': [
      'Schedule an appointment',
      'Arrive at the clinic and check-in',
      'Describe symptoms to the doctor',
      'Follow the prescribed treatment',
    ],
    'image': 'assets/images/doctor_image.png',
    'participants': 'Patient, Doctor, Nurse',
    'roles': [
      'Patient - describes symptoms and follows instructions',
      'Doctor - diagnoses and provides treatment',
      'Nurse - assists with medical procedures',
    ],
    'dialogues': [
      'Patient: "I’ve been feeling a bit feverish."',
      'Doctor: "Let’s check your temperature."',
    ],
  },
  '9. Attending a Birthday Party': {
    'description': 'A group of friends attending a birthday celebration.',
    'steps': [
      'RSVP to the invitation',
      'Bring a gift for the birthday person',
      'Participate in the party activities',
      'Enjoy the food and cake',
    ],
    'image': 'assets/images/birthday_image.png',
    'participants': 'Guest 1, Guest 2, Birthday Person, Party Host',
    'roles': [
      'Guest 1 - brings a gift and participates in games',
      'Guest 2 - sings happy birthday',
      'Birthday Person - enjoys the party',
      'Party Host - organizes the event',
    ],
    'dialogues': [
      'Guest 1: "Happy birthday, I brought you a gift!"',
      'Party Host: "Let’s start the cake cutting!"',
    ],
  },
  '10. Classroom Experience': {
    'description': 'Students working together in a classroom setting.',
    'steps': [
      'Listen to the teacher’s instructions',
      'Complete individual or group assignments',
      'Ask questions if needed',
      'Review the lesson and prepare for the next class',
    ],
    'image': 'assets/images/classroom_image.png',
    'participants': 'Student 1, Student 2, Teacher',
    'roles': [
      'Student 1 - participates in the class discussion',
      'Student 2 - works on assignments',
      'Teacher - leads the lesson',
    ],
    'dialogues': [
      'Teacher: "Please open your books to page 50."',
      'Student 1: "I don’t understand this concept."',
    ],
  },
};
