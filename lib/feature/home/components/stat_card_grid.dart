import 'package:flutter/material.dart';
import '../../../ds/components/app_card.dart';
import '../../../ds/layout/responsive.dart';
import '../../../ds/theme/spacing.dart';

class StatItem {
  final String label;
  final String value;
  final IconData icon;
  const StatItem({required this.label, required this.value, required this.icon});
}

class StatCardGrid extends StatelessWidget {
  final List<StatItem> items;
  const StatCardGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.of(context).gridColumns;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = Spacing.large;
        final double itemWidth = (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final item in items)
              SizedBox(
                width: itemWidth,
                child: AppCard(
                  child: Row(
                    children: [
                      Icon(item.icon),
                      const SizedBox(width: Spacing.large),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontFamily: 'Outfit'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontFamily: 'Outfit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}

