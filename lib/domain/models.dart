class SubjectModel {
  final String subject;
  final List<TopicModel> topics;
  
  SubjectModel({required this.subject, required this.topics});

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        subject: json['subject'] as String,
        topics: (json['topics'] as List<dynamic>)
            .map((t) => TopicModel.fromJson(t as Map<String, dynamic>))
            .toList(),
      );
}

class TopicModel {
  final String topic;
  final String content;
  final List<Map<String, dynamic>> questionsRaw;
  final List<String> questions;

  TopicModel({
    required this.topic,
    required this.content,
    required this.questionsRaw,
    required this.questions,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    final questionsList = (json['questions'] as List<dynamic>?) ?? [];
    final questionsRaw = questionsList.map((e) => e as Map<String, dynamic>).toList();
    final questions = questionsRaw.map((q) => q['question'] as String).toList();
    return TopicModel(
      topic: json['topic'] as String,
      content: (json['content'] as String?) ?? '',
      questionsRaw: questionsRaw,
      questions: questions,
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String topic;
  
  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.topic,
  });

  bool isCorrect(int selectedIndex) => selectedIndex == correctAnswerIndex;
}

class QuizSession {
  final List<QuizQuestion> questions;
  final int currentQuestionIndex;
  final int score;
  final Duration elapsed;
  final bool isCompleted;
  final List<int> userAnswers;
  final DateTime startedAt;

  QuizSession({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.elapsed = Duration.zero,
    this.isCompleted = false,
    List<int>? userAnswers,
    DateTime? startedAt,
  }) : userAnswers = userAnswers ?? List.filled(questions.length, -1),
       startedAt = startedAt ?? DateTime.now();

  QuizSession copyWith({
    List<QuizQuestion>? questions,
    int? currentQuestionIndex,
    int? score,
    Duration? elapsed,
    bool? isCompleted,
    List<int>? userAnswers,
    DateTime? startedAt,
  }) {
    return QuizSession(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      elapsed: elapsed ?? this.elapsed,
      isCompleted: isCompleted ?? this.isCompleted,
      userAnswers: userAnswers ?? this.userAnswers,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;
  double get progress => questions.isEmpty ? 0.0 : (currentQuestionIndex + 1) / questions.length;
  double get accuracy => questions.isEmpty ? 0.0 : score / questions.length;
}


