import 'package:flutter/material.dart';
import 'routes.dart';
import '../feature/question/question_screen.dart';
import '../shell/shell_screen.dart';
import '../shared/functions/platform.dart';
import '../domain/models.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings s) {
    switch (s.name) {
      case Routes.home:
        return platformRoute(const ShellScreen(initialIndex: 0));
      case Routes.topics:
        return platformRoute(const ShellScreen(initialIndex: 1));
      case Routes.practice:
        final TopicModel? topic = s.arguments as TopicModel?;
        return platformRoute(ShellScreen(
          initialIndex: 2,
          selectedTopic: topic,
        ));
      case Routes.question:
        return platformRoute(const QuestionScreen());
      case Routes.examNumber:
        return platformRoute(const ShellScreen(initialIndex: 2));
      case Routes.inARow:
        return platformRoute(const ShellScreen(initialIndex: 2));
    }
    return null;
  }
}