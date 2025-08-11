import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'models.dart';

abstract class LoadSubjectsUseCase {
  Future<List<SubjectModel>> execute();
}

class LoadSubjectsFromAssets implements LoadSubjectsUseCase {
  final String assetPath;
  const LoadSubjectsFromAssets(this.assetPath);

  @override
  Future<List<SubjectModel>> execute() async {
    final String raw = await rootBundle.loadString(assetPath);
    final List<dynamic> data = json.decode(raw) as List<dynamic>;
    return data
        .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class BuildQuizQuestionsUseCase {
  final Random _random = Random();

  List<QuizQuestion> execute(TopicModel topic) {
    if (topic.questions.isEmpty) {
      return [];
    }

    final List<QuizQuestion> result = [];

    for (final question in topic.questions) {
      final List<String> options = _generateOptions(question, topic);
      final int correctIndex = _random.nextInt(4);

      // Move correct answer to the correct index
      final correctAnswer = question;
      options[correctIndex] = correctAnswer;

      result.add(QuizQuestion(
        question: question,
        options: options,
        correctAnswerIndex: correctIndex,
        topic: topic.topic,
      ));
    }

    return result;
  }

  List<QuizQuestion> executeFromSubject(SubjectModel subject) {
    final List<QuizQuestion> allQuestions = [];

    for (final topic in subject.topics) {
      final topicQuestions = execute(topic);
      allQuestions.addAll(topicQuestions);
    }

    allQuestions.shuffle(_random);

    final limitedQuestions = allQuestions.take(10).toList();
    return limitedQuestions;
  }

  List<QuizQuestion> executeRandom(List<SubjectModel> subjects) {
    final List<QuizQuestion> allQuestions = [];

    for (final subject in subjects) {
      final subjectQuestions = executeFromSubject(subject);
      allQuestions.addAll(subjectQuestions);
    }

    allQuestions.shuffle(_random);
    final limitedQuestions = allQuestions.take(15).toList();
    return limitedQuestions;
  }

  List<String> _generateOptions(String question, TopicModel topic) {
    final List<String> options = [];

    // Add the correct answer
    options.add(question);

    // Generate plausible wrong answers based on content
    final List<String> wrongAnswers = _generateWrongAnswers(question, topic);

    // Add wrong answers, ensuring we have exactly 4 options
    for (int i = 0; i < 3 && i < wrongAnswers.length; i++) {
      options.add(wrongAnswers[i]);
    }

    // If we don't have enough wrong answers, add generic ones
    while (options.length < 4) {
      options.add(_generateGenericOption(question));
    }

    // Shuffle to randomize positions
    options.shuffle(_random);

    return options;
  }

  List<String> _generateWrongAnswers(String question, TopicModel topic) {
    final List<String> wrongAnswers = [];

    // Use other questions from the same topic as wrong answers
    for (final otherQuestion in topic.questions) {
      if (otherQuestion != question && wrongAnswers.length < 3) {
        wrongAnswers.add(otherQuestion);
      }
    }

    // Use content snippets if available
    if (topic.content.isNotEmpty && wrongAnswers.length < 3) {
      final sentences = topic.content.split('.');
      for (final sentence in sentences) {
        if (sentence.trim().length > 10 && wrongAnswers.length < 3) {
          wrongAnswers.add(sentence.trim());
        }
      }
    }

    return wrongAnswers;
  }

  String _generateGenericOption(String question) {
    // Generate generic wrong answers based on question type
    if (question.toLowerCase().contains('what')) {
      return 'This is not the correct answer';
    } else if (question.toLowerCase().contains('how')) {
      return 'This approach is incorrect';
    } else if (question.toLowerCase().contains('why')) {
      return 'This reasoning is flawed';
    } else {
      return 'None of the above';
    }
  }
}
