import 'package:edu_ui_assessment/ds/components/screen_header.dart';
import 'package:edu_ui_assessment/ds/theme/spacing.dart';
import 'package:edu_ui_assessment/state/app_state.dart';
import 'package:edu_ui_assessment/domain/models.dart';
import 'package:edu_ui_assessment/ds/components/custom_button.dart';
import 'components/answers_list.dart';
import 'components/check_answer_button.dart';
import 'components/question_header.dart';
import 'components/question_prompt.dart';
import 'package:flutter/material.dart';
import '../../ds/components/platform_scaffold.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuizSession? _currentQuiz;
  int? _selectedAnswerIndex;
  bool _answerSubmitted = false;
  bool _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    
    // Get the current quiz from AppState
    _currentQuiz = AppState.I.currentQuiz;
    
    if (_currentQuiz != null) {
      _initializeQuestionState();
    }
  }

  void _initializeQuestionState() {
    if (_currentQuiz == null) return;
    
    final currentQuestionIndex = _currentQuiz!.currentQuestionIndex;
    final userAnswers = _currentQuiz!.userAnswers;
    
    // Check if user has already answered this question
    if (currentQuestionIndex < userAnswers.length && userAnswers[currentQuestionIndex] != -1) {
      _selectedAnswerIndex = userAnswers[currentQuestionIndex];
      _answerSubmitted = true;
      _showCorrectAnswer = true;
    } else {
      // New question or no answer selected, reset state
      _selectedAnswerIndex = null;
      _answerSubmitted = false;
      _showCorrectAnswer = false;
    }
  }

  void _onAnswerSelected(int index) {
    if (_answerSubmitted) {
      return;
    }
    
    setState(() {
      if (index == -1) {
        // Deselect answer
        _selectedAnswerIndex = null;
      } else {
        // Select answer
        _selectedAnswerIndex = index;
      }
    });
  }

  void _checkAnswer() {
    if (_selectedAnswerIndex == null || _currentQuiz == null) {
      return;
    }

    setState(() {
      _answerSubmitted = true;
      _showCorrectAnswer = true;
    });

    // Submit answer to AppState
    AppState.I.answerQuestion(_selectedAnswerIndex!);
  }

  void _nextQuestion() {
    AppState.I.nextQuestion();
    
    // Update local state after navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _currentQuiz = AppState.I.currentQuiz;
          if (_currentQuiz != null) {
            _initializeQuestionState();
          }
        });
      }
    });
  }

  void _previousQuestion() {
    AppState.I.previousQuestion();
    
    // Update local state after navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _currentQuiz = AppState.I.currentQuiz;
          if (_currentQuiz != null) {
            _initializeQuestionState();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    
    if (_currentQuiz == null) {
      return PlatformScaffold(
        materialAppBar: null,
        cupertinoNavBar: null,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading quiz...', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _currentQuiz!.questions[_currentQuiz!.currentQuestionIndex];
    final isLastQuestion = _currentQuiz!.isLastQuestion;

    return PlatformScaffold(
      materialAppBar: null,
      cupertinoNavBar: null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double hPad = constraints.maxWidth < 360
              ? 12
              : constraints.maxWidth < 400
                  ? 16
                  : constraints.maxWidth < 480
                      ? 24
                      : 32;
          return Container(
            color: backgroundColor,
            child: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(hPad, Spacing.doubleExtraLarge, hPad, Spacing.s340),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenHeader(onBack: () => Navigator.of(context).pop()),
                      const SizedBox(height: Spacing.extraLarge),
                      QuestionHeader(
                        subject: AppState.I.currentSubject,
                        questionNumber: _currentQuiz!.currentQuestionIndex + 1,
                        totalQuestions: _currentQuiz!.questions.length,
                      ),
                      const SizedBox(height: Spacing.small),
                      QuestionPrompt(question: currentQuestion.question),
                      const SizedBox(height: Spacing.large),
                      AnswersList(
                        options: currentQuestion.options,
                        selectedIndex: _selectedAnswerIndex,
                        correctIndex: currentQuestion.correctAnswerIndex,
                        showCorrectAnswer: _showCorrectAnswer,
                        onAnswerSelected: _onAnswerSelected,
                      ),
                      const SizedBox(height: Spacing.medium),
                      if (_answerSubmitted)
                        Column(
                          children: [
                            Row(
                              children: [
                                if (_currentQuiz!.currentQuestionIndex > 0)
                                  Expanded(
                                    child: CustomButton(
                                      onPressed: _previousQuestion,
                                      text: 'Previous',
                                      backgroundColor: const Color(0xFF67E7FF),
                                    ),
                                  ),
                                if (_currentQuiz!.currentQuestionIndex > 0)
                                  const SizedBox(width: 16),
                                Expanded(
                                  child: CustomButton(
                                    onPressed: isLastQuestion ? () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Quiz completed! Score: ${_currentQuiz!.score}/${_currentQuiz!.questions.length}'),
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                    } : _nextQuestion,
                                    text: isLastQuestion ? 'Finish Quiz' : 'Next Question',
                                    backgroundColor: const Color(0xFF67E7FF),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        CheckAnswerButton(
                          onPressed: _selectedAnswerIndex != null ? _checkAnswer : null,
                        ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
