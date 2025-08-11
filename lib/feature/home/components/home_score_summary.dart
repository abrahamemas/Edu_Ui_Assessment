import 'package:flutter/material.dart';

class HomeScoreSummary extends StatelessWidget {
  final int score;
  
  const HomeScoreSummary({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    // Calculate percentage (assuming max score is 100, but we'll make it dynamic)
    final maxScore = 100;
    final percentage = score.clamp(0, maxScore);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$percentage',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                          color: const Color(0xFF070707),
                          fontFamily: 'Outfit',
                          fontSize: 42,
                          fontWeight: FontWeight.w500),
                ),
                Text(
                  ' / $maxScore',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                          color: const Color(0xFF1A633A),
                          fontFamily: 'Outfit',
                          fontSize: 32,
                          fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Text(
              'Your recent score',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                      color: const Color(0xFF070707),
                      fontFamily: 'Satoshi',
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          width: 178,
          height: 58,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF070707),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'More Details',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontFamily: 'Outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/icon_arrow_1.png',
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


