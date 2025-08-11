import 'package:flutter/material.dart';

class QuestionPrompt extends StatelessWidget {
  final String question;
  
  const QuestionPrompt({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontFamily: 'Outfit',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
    );
  }
}


