import 'package:flutter/material.dart';

class HomePerformanceCard extends StatelessWidget {
  final List<dynamic> subjects;
  final int questionsCompleted;
  final int mistakesMade;
  final Duration timeSpent;
  
  const HomePerformanceCard({
    super.key, 
    required this.subjects,
    required this.questionsCompleted,
    required this.mistakesMade,
    required this.timeSpent,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total questions from subjects
    final totalQuestions = subjects.fold<int>(0, (sum, subject) {
      final topics = subject.topics as List<dynamic>?;
      if (topics == null) return sum;
      return sum + topics.fold<int>(0, (topicSum, topic) => topicSum + ((topic.questions as List<dynamic>?)?.length ?? 0));
    });
    
    // Calculate time spent in hours and minutes
    final hoursSpent = timeSpent.inHours;
    final minutesSpent = timeSpent.inMinutes % 60;
    
    // Use real-time data or fallback to calculated values
    final finalQuestionsCompleted = questionsCompleted > 0 ? questionsCompleted : (totalQuestions * 0.5).round();
    final finalMistakesMade = mistakesMade > 0 ? mistakesMade : (totalQuestions * 0.3).round();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F5),
        borderRadius: BorderRadius.circular(37),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(0, -1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subjects.isNotEmpty 
                ? subjects.expand((subject) => (subject.topics as List<dynamic>?)?.map((topic) => topic.topic) ?? []).take(4).map((topicName) => 
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Text(
                        topicName ?? 'Unknown',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: const Color(0xFF454A48),
                              fontFamily: 'Outfit',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    )
                  ).toList()
                : [
                    Text(
                      'Social and society',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF454A48),
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'Economics',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF454A48),
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'Law',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF454A48),
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'Sociology',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF454A48),
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      '$hoursSpent',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: const Color(0xFF070707),
                            fontFamily: 'Outfit',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'h',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF454A48),
                              fontFamily: 'Outfit',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$minutesSpent',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: const Color(0xFF070707),
                            fontFamily: 'Outfit',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'min',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF454A48),
                              fontFamily: 'Outfit',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ]),
                  Text(
                    'Overall Time Spent',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF454A48),
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      '$finalQuestionsCompleted',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: const Color(0xFF070707),
                            fontFamily: 'Outfit',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '/$totalQuestions',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF454A48),
                              fontFamily: 'Outfit',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ]),
                  Text(
                    'Variants Solved',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF454A48),
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$finalMistakesMade',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF070707),
                          fontFamily: 'Outfit',
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    'Mistakes Made',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF454A48),
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


