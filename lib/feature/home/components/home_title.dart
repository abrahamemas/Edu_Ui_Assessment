import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Studies',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF070707),
                fontFamily: 'Outfit',
                fontSize: 42,
                height: 1.1,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          'Exam Preparation',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF1A633A),
                fontSize: 42,
                fontFamily: 'Outfit',
                height: 1.1,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}




