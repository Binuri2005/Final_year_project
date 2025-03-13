import 'package:app/viewmodels/daily_skills/daily_skills.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengeCreator extends StatefulWidget {
  const ChallengeCreator({Key? key}) : super(key: key);

  @override
  State<ChallengeCreator> createState() => _ChallengeCreatorState();
}

class _ChallengeCreatorState extends State<ChallengeCreator>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final List<String> _tasks = [];
  final TextEditingController _newTaskController = TextEditingController();
  TimeOfDay _startDate = TimeOfDay.fromDateTime(DateTime.now());
  TimeOfDay _endDate =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(days: 7)));
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;
  final ScrollController _scrollController = ScrollController();
  final List<Color> _taskColors = [
    Colors.purple[400]!,
    Colors.blue[400]!,
    Colors.teal[400]!,
    Colors.green[400]!,
    Colors.amber[400]!,
    Colors.orange[400]!,
    Colors.red[400]!,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _newTaskController.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _addTask() {
    if (_newTaskController.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add(_newTaskController.text.trim());
        _newTaskController.clear();
      });

      // Scroll to bottom after adding task
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _createChallenge() {
    if (_titleController.text.trim().isEmpty) {
      _showErrorSnackBar('Please add a title');
      return;
    }

    if (_tasks.isEmpty) {
      _showErrorSnackBar('Please add at least one task');
      return;
    }

    // Here you would typically save the challenge to your database
    final challenge = {
      'title': _titleController.text,
      'startDate': _startDate,
      'endDate': _endDate,
      'tasks': _tasks,
    };

    print(challenge);

    context.read<DailySkillViewModel>().createChallenge(
          title: _titleController.text,
          startTime: (_startDate),
          endTime: (_endDate),
          steps: _tasks,
          onSuccess: showSuccessDialog,
          onFailure: () => _showErrorSnackBar(
            context.read<DailySkillViewModel>().errorMessage ??
                'Failed to create challenge',
          ),
        );
  }

  void showSuccessDialog() {
    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Challenge Created!')
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your challenge has been successfully created.',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 16),
              _buildChallengeInfoRow(Icons.title, _titleController.text),
              _buildChallengeInfoRow(Icons.calendar_today,
                  'Starts at ${_startDate.format(context)}'),
              _buildChallengeInfoRow(Icons.list, '${_tasks.length} tasks')
            ],
          ),
          actions: [
            TextButton(
              child: Text('DONE'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                // Reset the form
                setState(() {
                  _titleController.clear();
                  _tasks.clear();
                  _startDate = TimeOfDay.fromDateTime(DateTime.now());
                  _endDate = TimeOfDay.fromDateTime(
                      DateTime.now().add(const Duration(days: 7)));
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildChallengeInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          SizedBox(width: 8),
          Flexible(child: Text(text)),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Color _getTaskColor(int index) {
    return _taskColors[index % _taskColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Create Challenge',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('About Challenges'),
                  content: Text(
                    'Challenges help you set and track goals over time.\n\nAdd tasks to break down your challenge into manageable steps.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('GOT IT'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Colorful header
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Design Your Challenge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Challenge Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _titleController,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'What do you want to achieve?',
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: const Icon(Icons.title),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Date Selection Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Time Frame',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _selectDate(context, true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.play_circle_filled,
                                              color: Colors.green[600],
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Starts',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _startDate.format(context),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _selectDate(context, false),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.flag,
                                              color: Colors.red[600],
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Ends',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _endDate.format(context),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tasks Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.task_alt,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Challenge Tasks',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (_tasks.isNotEmpty)
                                GestureDetector(
                                  onTap: _toggleExpand,
                                  child: Row(
                                    children: [
                                      Text(
                                        _isExpanded ? 'Hide' : 'Show All',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      RotationTransition(
                                        turns: Tween(begin: 0.0, end: 0.5)
                                            .animate(_animation),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _newTaskController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Add a new task',
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: const Icon(Icons.assignment),
                                  ),
                                  onSubmitted: (_) => _addTask(),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: _addTask,
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  tooltip: 'Add Task',
                                ),
                              ),
                            ],
                          ),
                          if (_tasks.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: SizedBox(
                                height: _isExpanded || _tasks.length <= 3
                                    ? null
                                    : 200, // Fixed height when collapsed
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: _isExpanded
                                      ? const NeverScrollableScrollPhysics()
                                      : const BouncingScrollPhysics(),
                                  itemCount: _tasks.length,
                                  itemBuilder: (context, index) {
                                    final Color taskColor =
                                        _getTaskColor(index);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: taskColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                color:
                                                    taskColor.withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                    color: taskColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                _tasks[index],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                              onPressed: () =>
                                                  _removeTask(index),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (!_isExpanded && _tasks.length > 3) ...[
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0),
                                      Colors.white,
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: TextButton.icon(
                                  onPressed: _toggleExpand,
                                  icon: const Icon(Icons.unfold_more),
                                  label: Text(
                                    'Show All ${_tasks.length} Tasks',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                          ] else ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.amber[100]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Colors.amber[800]),
                                  const SizedBox(width: 8),
                                  const Flexible(
                                    child: Text(
                                      'Add tasks to break down your challenge into achievable steps.',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (_tasks.isNotEmpty) {
            _createChallenge();
          } else {
            _showErrorSnackBar('Please add at least one task');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: ElevatedButton(
              onPressed: _createChallenge,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.rocket_launch),
                  const SizedBox(width: 8),
                  Text(
                    'CREATE CHALLENGE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
