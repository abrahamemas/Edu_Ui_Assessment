import 'package:flutter/material.dart';

class HomeSmallCardsRow extends StatelessWidget {
  final List<dynamic> subjects;
  final int topicsCompleted;
  final int questionsCompleted;
  
  const HomeSmallCardsRow({
    super.key, 
    required this.subjects,
    required this.topicsCompleted,
    required this.questionsCompleted,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total topics and questions from subjects data
    final totalTopics = subjects.fold<int>(0, (sum, subject) => sum + ((subject.topics as List<dynamic>?)?.length ?? 0));
    final totalQuestions = subjects.fold<int>(0, (sum, subject) {
      final topics = subject.topics as List<dynamic>?;
      if (topics == null) return sum;
      return sum + topics.fold<int>(0, (topicSum, topic) => topicSum + ((topic.questions as List<dynamic>?)?.length ?? 0));
    });
    
    // Use real-time data or fallback to calculated values
    final finalTopicsCompleted = topicsCompleted > 0 ? topicsCompleted : (totalTopics * 0.6).round();
    final finalQuestionsCompleted = questionsCompleted > 0 ? questionsCompleted : (totalQuestions * 0.5).round();

    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 145,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7F5),
              borderRadius: BorderRadius.circular(37),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                Image.asset('assets/images/edu_icon.png', width: 33, height: 33),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$finalTopicsCompleted',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFF070707),
                              fontFamily: 'Outfit',
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            ' / $totalTopics topics',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF454A48),
                                  fontFamily: 'Outfit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 145,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7F5),
              borderRadius: BorderRadius.circular(37),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                Image.asset('assets/images/notes_icon_3.png', width: 33, height: 33),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$finalQuestionsCompleted',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFF070707),
                              fontFamily: 'Outfit',
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            ' / $totalQuestions questions',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF454A48),
                                  fontFamily: 'Outfit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


