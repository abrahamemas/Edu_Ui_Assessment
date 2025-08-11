import 'dart:async';
import '../domain/models.dart';

class AppState {
  // Singleton instance
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  static AppState get I => _instance;
  AppState._internal();

  // Streams for reactive UI updates
  final StreamController<List<SubjectModel>> _subjectsController = StreamController<List<SubjectModel>>.broadcast();
  final StreamController<QuizSession?> _quizController = StreamController<QuizSession?>.broadcast();
  final StreamController<int> _scoreController = StreamController<int>.broadcast();
  final StreamController<String> _currentSubjectController = StreamController<String>.broadcast();
  
  // New streams for real-time statistics
  final StreamController<Map<String, dynamic>> _userStatsController = StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Duration> _timeSpentController = StreamController<Duration>.broadcast();
  final StreamController<int> _questionsCompletedController = StreamController<int>.broadcast();
  final StreamController<int> _mistakesController = StreamController<int>.broadcast();

  // Public streams
  Stream<List<SubjectModel>> get subjectsStream => _subjectsController.stream;
  Stream<QuizSession?> get quizStream => _quizController.stream;
  Stream<int> get scoreStream => _scoreController.stream;
  Stream<String> get currentSubjectStream => _currentSubjectController.stream;
  
  // New public streams for real-time updates
  Stream<Map<String, dynamic>> get userStatsStream => _userStatsController.stream;
  Stream<Duration> get timeSpentStream => _timeSpentController.stream;
  Stream<int> get questionsCompletedStream => _questionsCompletedController.stream;
  Stream<int> get mistakesStream => _mistakesController.stream;

  // Current state
  List<SubjectModel> _subjects = [];
  QuizSession? _currentQuizSession;
  int _totalScore = 0;
  String _currentSubject = '';
  
  // User progress tracking
  final List<QuizSession> _completedQuizzes = [];
  DateTime? _firstQuizStartTime;
  
  // Real-time statistics
  int _questionsCompleted = 0;
  int _totalMistakes = 0;
  Duration _totalTimeSpent = Duration.zero;
  
  // Timer for real-time updates
  Timer? _statsUpdateTimer;

  // Getters
  List<SubjectModel> get subjects => _subjects;
  QuizSession? get currentQuiz => _currentQuizSession;
  int get totalScore => _totalScore;
  String get currentSubject => _currentSubject;
  int get questionsCompleted => _questionsCompleted;
  int get totalMistakes => _totalMistakes;
  Duration get totalTimeSpent => _totalTimeSpent;

  // Initialize subjects
  void setSubjects(List<SubjectModel> subjects) {
    _subjects = subjects;
    _subjectsController.add(_subjects);
  }

  // Start a new quiz
  void startQuiz(List<QuizQuestion> questions, {String? subject}) {
    // Track first quiz start time for overall time calculation
    _firstQuizStartTime ??= DateTime.now();
    
    _currentQuizSession = QuizSession(questions: questions);
    if (subject != null) _currentSubject = subject;
    
    _quizController.add(_currentQuizSession);
    _currentSubjectController.add(_currentSubject);
    
    // Start real-time statistics updates
    _startStatsTracking();
    
    // Emit initial statistics
    _emitUserStats();
  }
  
  // Start real-time statistics tracking
  void _startStatsTracking() {
    _statsUpdateTimer?.cancel();
    _statsUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentQuizSession != null && !_currentQuizSession!.isCompleted) {
        _updateTimeSpent();
        _emitUserStats();
      } else {
        timer.cancel();
      }
    });
  }
  
  // Update time spent and emit updates
  void _updateTimeSpent() {
    if (_firstQuizStartTime != null) {
      _totalTimeSpent = DateTime.now().difference(_firstQuizStartTime!);
      _timeSpentController.add(_totalTimeSpent);
    }
  }
  
  // Emit user statistics to all listeners
  void _emitUserStats() {
    final stats = getUserStats();
    _userStatsController.add(stats);
  }

  // Answer current question
  void answerQuestion(int selectedOptionIndex) {
    if (_currentQuizSession == null || _currentQuizSession!.isCompleted) {
      return;
    }

    // Handle deselection
    if (selectedOptionIndex == -1) {
      // Update user answers to mark as not answered
      final newUserAnswers = List<int>.from(_currentQuizSession!.userAnswers);
      newUserAnswers[_currentQuizSession!.currentQuestionIndex] = -1;
      
      _currentQuizSession = _currentQuizSession!.copyWith(
        userAnswers: newUserAnswers,
      );
      
      _quizController.add(_currentQuizSession);
      return;
    }

    final currentQuestion = _currentQuizSession!.questions[_currentQuizSession!.currentQuestionIndex];
    final isCorrect = currentQuestion.isCorrect(selectedOptionIndex);
    
    // Update user answers
    final newUserAnswers = List<int>.from(_currentQuizSession!.userAnswers);
    newUserAnswers[_currentQuizSession!.currentQuestionIndex] = selectedOptionIndex;
    
    // Update score (2 points for correct answer)
    final newScore = isCorrect ? _currentQuizSession!.score + 2 : _currentQuizSession!.score;
    
    // Update real-time statistics
    if (isCorrect) {
      _totalScore += 2; // Add 2 points to total score
      _questionsCompleted++;
    } else {
      _totalMistakes++;
    }
    
    _currentQuizSession = _currentQuizSession!.copyWith(
      score: newScore,
      userAnswers: newUserAnswers,
    );
    
    // Emit immediate updates
    _scoreController.add(_totalScore);
    _questionsCompletedController.add(_questionsCompleted);
    _mistakesController.add(_totalMistakes);
    _emitUserStats();
    
    _quizController.add(_currentQuizSession);
  }

  // Move to next question
  void nextQuestion() {
    if (_currentQuizSession == null) {
      return;
    }

    if (_currentQuizSession!.isLastQuestion) {
      // Quiz completed
      _completeQuiz();
    } else {
      // Move to next question
      _currentQuizSession = _currentQuizSession!.copyWith(
        currentQuestionIndex: _currentQuizSession!.currentQuestionIndex + 1,
      );
      _quizController.add(_currentQuizSession);
    }
  }

  // Move to previous question
  void previousQuestion() {
    if (_currentQuizSession == null || _currentQuizSession!.currentQuestionIndex == 0) {
      return;
    }

    _currentQuizSession = _currentQuizSession!.copyWith(
      currentQuestionIndex: _currentQuizSession!.currentQuestionIndex - 1,
    );
    _quizController.add(_currentQuizSession);
  }

  // Complete the quiz
  void _completeQuiz() {
    if (_currentQuizSession == null) return;

    // Stop real-time tracking
    _statsUpdateTimer?.cancel();

    _currentQuizSession = _currentQuizSession!.copyWith(
      isCompleted: true,
      elapsed: DateTime.now().difference(_currentQuizSession!.startedAt),
    );

    // Store completed quiz for statistics
    _completedQuizzes.add(_currentQuizSession!);

    // Update total score (already updated in answerQuestion)
    // _totalScore += _currentQuizSession!.score; // Removed as it's handled in answerQuestion

    // Emit final statistics
    _emitUserStats();
    _scoreController.add(_totalScore);
    _questionsCompletedController.add(_questionsCompleted);
    _mistakesController.add(_totalMistakes);

    _quizController.add(_currentQuizSession);
  }

  // Reset current quiz
  void resetQuiz() {
    // Stop real-time tracking
    _statsUpdateTimer?.cancel();
    
    _currentQuizSession = null;
    _quizController.add(null);
  }

  // Get real user statistics for home screen
  Map<String, dynamic> getUserStats() {
    // Calculate topics completed (unique topics from all completed quizzes)
    final Set<String> completedTopics = {};
    int totalQuestionsCompleted = 0;
    int totalMistakes = 0;
    
    for (final quiz in _completedQuizzes) {
      for (int i = 0; i < quiz.questions.length; i++) {
        if (quiz.userAnswers[i] != -1) {
          completedTopics.add(quiz.questions[i].topic);
          totalQuestionsCompleted++;
          
          // Count mistakes
          if (quiz.userAnswers[i] != quiz.questions[i].correctAnswerIndex) {
            totalMistakes++;
          }
        }
      }
    }
    
    // Calculate total topics and questions from subjects
    final totalTopics = _subjects.fold<int>(0, (sum, subject) => sum + subject.topics.length);
    final totalQuestions = _subjects.fold<int>(0, (sum, subject) => 
        sum + subject.topics.fold<int>(0, (topicSum, topic) => topicSum + topic.questions.length));
    
    // Calculate time spent
    Duration totalTimeSpent = Duration.zero;
    if (_firstQuizStartTime != null) {
      totalTimeSpent = DateTime.now().difference(_firstQuizStartTime!);
    }
    
    return {
      'totalScore': _totalScore,
      'totalTopics': totalTopics,
      'topicsCompleted': completedTopics.length,
      'totalQuestions': totalQuestions,
      'questionsCompleted': totalQuestionsCompleted,
      'mistakesMade': totalMistakes,
      'timeSpent': totalTimeSpent,
      'completedQuizzes': _completedQuizzes.length,
    };
  }

  // Get topic-specific statistics for slide view
  Map<String, Map<String, dynamic>> getTopicStats() {
    final Map<String, Map<String, dynamic>> topicStats = {};
    
    for (final quiz in _completedQuizzes) {
      for (int i = 0; i < quiz.questions.length; i++) {
        final topic = quiz.questions[i].topic;
        if (!topicStats.containsKey(topic)) {
          topicStats[topic] = {
            'questionsCompleted': 0,
            'mistakesMade': 0,
            'timeSpent': Duration.zero,
          };
        }
        
        if (quiz.userAnswers[i] != -1) {
          topicStats[topic]!['questionsCompleted'] = (topicStats[topic]!['questionsCompleted'] as int) + 1;
          
          if (quiz.userAnswers[i] != quiz.questions[i].correctAnswerIndex) {
            topicStats[topic]!['mistakesMade'] = (topicStats[topic]!['mistakesMade'] as int) + 1;
          }
        }
      }
    }
    
    return topicStats;
  }

  // Get quiz statistics
  Map<String, dynamic> getQuizStats() {
    if (_currentQuizSession == null) return {};
    
    return {
      'totalQuestions': _currentQuizSession!.questions.length,
      'correctAnswers': _currentQuizSession!.score,
      'accuracy': _currentQuizSession!.accuracy,
      'timeElapsed': _currentQuizSession!.elapsed,
      'subject': _currentSubject,
    };
  }

  // Get performance by topic
  Map<String, int> getTopicPerformance() {
    if (_currentQuizSession == null) return {};
    
    final Map<String, int> topicScores = {};
    final Map<String, int> topicTotals = {};
    
    for (int i = 0; i < _currentQuizSession!.questions.length; i++) {
      final topic = _currentQuizSession!.questions[i].topic;
      final isCorrect = _currentQuizSession!.userAnswers[i] == _currentQuizSession!.questions[i].correctAnswerIndex;
      
      topicScores[topic] = (topicScores[topic] ?? 0) + (isCorrect ? 1 : 0);
      topicTotals[topic] = (topicTotals[topic] ?? 0) + 1;
    }
    
    return topicScores;
  }

  // Cleanup
  void dispose() {
    _statsUpdateTimer?.cancel();
    _subjectsController.close();
    _quizController.close();
    _scoreController.close();
    _currentSubjectController.close();
    _userStatsController.close();
    _timeSpentController.close();
    _questionsCompletedController.close();
    _mistakesController.close();
  }
}


