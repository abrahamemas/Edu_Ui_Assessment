import 'package:flutter/material.dart';

class PracticeTitle extends StatelessWidget {
  const PracticeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Challenge your\nknowledge',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: const Color(0xFFF4F6F6),
            fontFamily: 'Outfit',
            fontSize: 42,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}




