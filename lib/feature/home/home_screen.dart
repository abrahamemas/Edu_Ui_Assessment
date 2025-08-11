import 'package:edu_ui_assessment/feature/home/components/home_small_cards_row.dart';
import 'package:flutter/material.dart';
import '../../ds/components/platform_scaffold.dart';
import '../../state/app_state.dart';
import 'components/home_header.dart';
import 'components/home_performance_card.dart';
import 'components/home_score_summary.dart';
import 'components/home_title.dart';
import 'dart:async';
import '../../ds/theme/spacing.dart';
import '../../ds/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  List<dynamic> _subjects = [];
  int _totalScore = 0;
  int _questionsCompleted = 0;
  int _totalMistakes = 0;
  Duration _totalTimeSpent = Duration.zero;
  
  // Stream subscriptions for real-time updates
  late StreamSubscription<List<dynamic>> _subjectsSubscription;
  late StreamSubscription<int> _scoreSubscription;
  late StreamSubscription<int> _questionsCompletedSubscription;
  late StreamSubscription<int> _mistakesSubscription;
  late StreamSubscription<Duration> _timeSpentSubscription;
  late StreamSubscription<Map<String, dynamic>> _userStatsSubscription;

  @override
  void initState() {
    super.initState();
    // Get initial data
    _subjects = AppState.I.subjects;
    _totalScore = AppState.I.totalScore;
    _questionsCompleted = AppState.I.questionsCompleted;
    _totalMistakes = AppState.I.totalMistakes;
    _totalTimeSpent = AppState.I.totalTimeSpent;
    
    // Subscribe to real-time updates
    _subjectsSubscription = AppState.I.subjectsStream.listen((subjects) {
      if (mounted) {
        setState(() {
          _subjects = subjects;
        });
      }
    });
    
    _scoreSubscription = AppState.I.scoreStream.listen((score) {
      if (mounted) {
        setState(() {
          _totalScore = score;
        });
      }
    });
    
    _questionsCompletedSubscription = AppState.I.questionsCompletedStream.listen((completed) {
      if (mounted) {
        setState(() {
          _questionsCompleted = completed;
        });
      }
    });
    
    _mistakesSubscription = AppState.I.mistakesStream.listen((mistakes) {
      if (mounted) {
        setState(() {
          _totalMistakes = mistakes;
        });
      }
    });
    
    _timeSpentSubscription = AppState.I.timeSpentStream.listen((timeSpent) {
      if (mounted) {
        setState(() {
          _totalTimeSpent = timeSpent;
        });
      }
    });
    
    _userStatsSubscription = AppState.I.userStatsStream.listen((stats) {
      if (mounted) {
        setState(() {
          _totalScore = stats['totalScore'] ?? _totalScore;
          _questionsCompleted = stats['questionsCompleted'] ?? _questionsCompleted;
          _totalMistakes = stats['mistakesMade'] ?? _totalMistakes;
          _totalTimeSpent = stats['timeSpent'] ?? _totalTimeSpent;
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel all subscriptions
    _subjectsSubscription.cancel();
    _scoreSubscription.cancel();
    _questionsCompletedSubscription.cancel();
    _mistakesSubscription.cancel();
    _timeSpentSubscription.cancel();
    _userStatsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color green = ColorLight.primaryGreen;
    return PlatformScaffold(
      materialAppBar: null,
      cupertinoNavBar: null,
      bottomBar: null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double hPad = _calculateHorizontalPadding(constraints.maxWidth);
          final double topPadding = _calculateTopPadding(constraints.maxHeight);
          return Container(
            color: green,
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(hPad, topPadding, hPad, Spacing.s340),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: Spacing.extraLarge),
                    const HomeTitle(),
                    const SizedBox(height: Spacing.extraLarge),
                    HomeScoreSummary(score: _totalScore),
                    const SizedBox(height: Spacing.doubleExtraLarge),
                    HomeSmallCardsRow(
                      subjects: _subjects,
                      topicsCompleted: _subjects.length,
                      questionsCompleted: _questionsCompleted,
                    ),
                    const SizedBox(height: Spacing.doubleExtraLarge),
                    HomePerformanceCard(
                      subjects: _subjects,
                      questionsCompleted: _questionsCompleted,
                      mistakesMade: _totalMistakes,
                      timeSpent: _totalTimeSpent,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper methods for responsive design
  double _calculateHorizontalPadding(double width) {
    if (width >= 1200) return 48; // Large tablets
    if (width >= 768) return 32;  // Tablets
    if (width >= 400) return 24;  // Large phones
    return 16; // Small phones
  }

  double _calculateTopPadding(double height) {
    if (height >= 800) return 40; // Tall screens
    if (height >= 600) return 32; // Medium screens
    return 24; // Small screens
  }
}
