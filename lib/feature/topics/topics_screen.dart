import 'dart:async';

import 'package:edu_ui_assessment/ds/theme/colors.dart';
import 'package:edu_ui_assessment/ds/theme/spacing.dart';
import 'package:edu_ui_assessment/state/app_state.dart';
import 'package:edu_ui_assessment/domain/models.dart';
import 'package:flutter/material.dart';
import '../../ds/components/platform_scaffold.dart';
import '../../router/routes.dart';
import 'components/topic_tile.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});
  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  late StreamSubscription<List<dynamic>> _subjectsSubscription;
  List<dynamic> _subjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Check if subjects are already loaded
    final currentSubjects = AppState.I.subjects;
    if (currentSubjects.isNotEmpty) {
      setState(() {
        _subjects = currentSubjects;
        _isLoading = false;
      });
    }
    
    _subjectsSubscription = AppState.I.subjectsStream.listen((subjects) {
      if (mounted) {
        setState(() {
          _subjects = subjects;
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _subjectsSubscription.cancel();
    super.dispose();
  }

  void _onTopicTap(TopicModel topic) {
    // Navigate to practice screen with the selected topic
    Navigator.of(context).pushNamed(Routes.practice, arguments: topic);
  }

  @override
  Widget build(BuildContext context) {
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
          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(hPad, Spacing.doubleExtraLarge, hPad, Spacing.s340),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Topics',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          color: ColorLight.grayLabel,
                          fontFamily: 'Outfit',
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: Spacing.doubleExtraLarge),
                  if (_isLoading)
                    const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading topics...', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    )
                  else if (_subjects.isEmpty)
                    const Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 48),
                          SizedBox(height: 16),
                          Text('No topics found', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _subjects.fold<int>(0, (sum, subject) => sum + ((subject.topics as List<dynamic>?)?.length ?? 0)),
                      separatorBuilder: (_, __) => const SizedBox(height: Spacing.extraLarge),
                      itemBuilder: (context, index) {
                        // Find the topic at this index across all subjects
                        TopicModel? topic;
                        int currentIndex = 0;
                        
                        for (final subject in _subjects) {
                          final topics = subject.topics as List<dynamic>?;
                          if (topics != null) {
                            for (final topicItem in topics) {
                              if (currentIndex == index) {
                                topic = topicItem as TopicModel;
                                break;
                              }
                              currentIndex++;
                            }
                            if (topic != null) break;
                          }
                        }
                        
                        if (topic == null) return const SizedBox.shrink();
                        
                        return TopicTile(
                          title: topic.topic,
                          icon: 'assets/images/topic_icon.png',
                          count: topic.questions.length,
                          onTap: () => _onTopicTap(topic!),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


