import 'package:flutter/material.dart';

class QuestionHeader extends StatelessWidget {
  final String subject;
  final int questionNumber;
  final int totalQuestions;
  
  const QuestionHeader({
    super.key,
    required this.subject,
    required this.questionNumber,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subject,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF31F797),
                fontFamily: 'Outfit',
                fontSize: 34,
                fontWeight: FontWeight.w400,
              ),
        ),
        const Spacer(),
        Text(
          '#$questionNumber',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF31F797),
                fontFamily: 'Outfit',
                fontSize: 34,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}


