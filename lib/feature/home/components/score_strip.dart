import 'package:flutter/material.dart';
import '../../../ds/components/app_card.dart';
import '../../../ds/theme/spacing.dart';

class ScoreStrip extends StatelessWidget {
  final int score;
  final int total;
  const ScoreStrip({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = (total == 0) ? 0.0 : (score / total).clamp(0.0, 1.0);
    return AppCard(
      padding: const EdgeInsets.all(Spacing.large),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Progress',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontFamily: 'Outfit'),
                ),
                const SizedBox(height: Spacing.small),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(minHeight: 8, value: percent),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.extraLarge),
          Text(
            '$score/$total',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontFamily: 'Outfit'),
          ),
        ],
      ),
    );
  }
}

