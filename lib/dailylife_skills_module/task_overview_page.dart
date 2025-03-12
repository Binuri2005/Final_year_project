import 'package:app/viewmodels/daily_skills/daily_skills.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskOverviewPage extends StatefulWidget {
  final DailySkill task;

  const TaskOverviewPage({super.key, required this.task});

  @override
  State<TaskOverviewPage> createState() => _TaskOverviewPageState();
}

class _TaskOverviewPageState extends State<TaskOverviewPage> {
  List<String> completedStepsID = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressPercentage =
        (completedStepsID.length / widget.task.steps.length) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showTaskInfoDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.primaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Header with Animation
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _buildCategoryHeader(context),
                ),

                SizedBox(height: 24),

                // Progress Card with Animation
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _buildProgressCard(progressPercentage),
                ),

                SizedBox(height: 24),

                // Steps Section Header
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.format_list_numbered,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Steps Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),

                // List of Steps with Animation
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _buildStepsList(theme),
                ),

                SizedBox(height: 32),

                // Start Button with Animation
                SizedBox(
                  child: widget.task.steps.length == completedStepsID.length
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<DailySkillViewModel>()
                                    .submitRoutine(
                                  widget.task.id,
                                  completedStepsID,
                                  () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              label: Text("Mark as complete"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    final theme = Theme.of(context);
    IconData categoryIcon = _getCategoryIcon();
    Color iconColor = _getCategoryColor(theme);

    return Card(
      elevation: 4,
      shadowColor: theme.primaryColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.cardColor,
              theme.cardColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  categoryIcon,
                  size: 40,
                  color: iconColor,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${widget.task.steps.length} steps • ${_getEstimatedTime()} min',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(double progressPercentage) {
    final isComplete = progressPercentage == 100;

    return Card(
      elevation: 3,
      shadowColor: Colors.green.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isComplete ? Icons.check_circle : Icons.pie_chart,
                      color: isComplete ? Colors.green : Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isComplete
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${progressPercentage.toInt()}%',
                    style: TextStyle(
                      color: isComplete ? Colors.green : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: completedStepsID.length / widget.task.steps.length,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isComplete ? Colors.green : Colors.blue,
                ),
                minHeight: 10,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${completedStepsID.length}/${widget.task.steps.length} steps completed',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                if (isComplete)
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 16,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'All done!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsList(ThemeData theme) {
    return Card(
      elevation: 2,
      shadowColor: theme.primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.task.steps.length,
          separatorBuilder: (context, index) => Divider(height: 24),
          itemBuilder: (context, index) {
            final step = widget.task.steps[index];
            final isCompleted = completedStepsID.contains(step.id);

            return InkWell(
              onTap: () {
                setState(() {
                  if (isCompleted) {
                    completedStepsID.remove(step.id);
                  } else {
                    completedStepsID.add(step.id);
                  }
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? Colors.green
                            : theme.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: isCompleted
                          ? Icon(Icons.check, size: 16, color: Colors.white)
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: isCompleted ? Colors.grey : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: isCompleted,
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            completedStepsID.add(step.id);
                          } else {
                            completedStepsID.remove(step.id);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showTaskInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About This Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Estimated time: ${_getEstimatedTime()} min',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.list_alt, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    '${widget.task.steps.length} steps',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon() {
    String title = widget.task.title.toLowerCase();

    if (title.contains('morning')) {
      return Icons.wb_sunny;
    } else if (title.contains('night')) {
      return Icons.nightlight_round;
    } else if (title.contains('meal')) {
      return Icons.restaurant;
    } else if (title.contains('hygiene')) {
      return Icons.soap;
    } else if (title.contains('chores')) {
      return Icons.cleaning_services;
    } else if (title.contains('school')) {
      return Icons.school;
    } else {
      return Icons.list_alt;
    }
  }

  Color _getCategoryColor(ThemeData theme) {
    String title = widget.task.title.toLowerCase();

    if (title.contains('morning')) {
      return Colors.orange;
    } else if (title.contains('night')) {
      return Colors.indigo;
    } else if (title.contains('meal')) {
      return Colors.green;
    } else if (title.contains('hygiene')) {
      return Colors.blue;
    } else if (title.contains('chores')) {
      return Colors.purple;
    } else if (title.contains('school')) {
      return Colors.teal;
    } else {
      return theme.primaryColor;
    }
  }

  int _getEstimatedTime() {
    // Estimate based on number of steps (2 minutes per step)
    return widget.task.steps.length * 2;
  }
}
