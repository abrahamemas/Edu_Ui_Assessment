import 'package:edu_ui_assessment/ds/components/screen_header_2.dart';
import 'package:edu_ui_assessment/ds/theme/spacing.dart';
import 'package:edu_ui_assessment/domain/models.dart';
import 'package:edu_ui_assessment/domain/usecases.dart';
import 'package:edu_ui_assessment/state/app_state.dart';
import 'components/mistakes_banner.dart';
import 'components/practice_tiles_row.dart';
import 'components/practice_tiles_row_two.dart';
import 'components/practice_title.dart';
import 'components/practice_type_dropdown.dart';
import 'package:flutter/material.dart';
import '../../ds/components/platform_scaffold.dart';
import '../../router/routes.dart';

class PracticeScreen extends StatefulWidget {
  final TopicModel? selectedTopic;
  
  const PracticeScreen({super.key, this.selectedTopic});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _startRandomQuiz() {
    final subjects = AppState.I.subjects;
    
    if (subjects.isNotEmpty) {
      final buildQuiz = BuildQuizQuestionsUseCase();
      final questions = buildQuiz.executeRandom(subjects);
      
      if (questions.isNotEmpty) {
        AppState.I.startQuiz(questions, subject: 'Random Quiz');
        
        if (mounted) {
          Navigator.of(context).pushNamed(Routes.question);
        }
      }
    }
  }

  void _startTopicQuiz() {
    if (widget.selectedTopic != null) {
      final buildQuiz = BuildQuizQuestionsUseCase();
      final questions = buildQuiz.execute(widget.selectedTopic!);
      
      if (questions.isNotEmpty) {
        AppState.I.startQuiz(questions, subject: widget.selectedTopic!.topic);
        
        if (mounted) {
          Navigator.of(context).pushNamed(Routes.question);
        }
      }
    } else {
      // Navigate to topics screen if no topic selected
      Navigator.of(context).pushNamed(Routes.topics);
    }
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
              padding: EdgeInsets.fromLTRB(
                  hPad, Spacing.doubleExtraLarge, hPad, Spacing.s340),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SecondScreenHeader(showBack: true),
                  const SizedBox(height: Spacing.large),
                  const PracticeTitle(),
                  const PracticeTypeDropdown(),
                  const SizedBox(height: Spacing.doubleExtraLarge),
                  PracticeTilesRow(
                    tileWidth: (MediaQuery.of(context).size.width -
                            2 * hPad -
                            Spacing.small) /
                        2,
                    onFirstTap: _startRandomQuiz,
                    onSecondTap: () {
                      // Exam Number functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Exam Number feature coming soon!')),
                      );
                    },
                  ),
                  const SizedBox(height: Spacing.small),
                  PracticeTilesRowTwo(
                    tileWidth: (MediaQuery.of(context).size.width -
                            2 * hPad -
                            Spacing.small) /
                        2,
                    onFirstTap: _startTopicQuiz,
                    onSecondTap: () {
                      // In a row functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('In a row feature coming soon!')),
                      );
                    },
                  ),
                  const SizedBox(height: Spacing.small),
                  const MistakesBanner(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
