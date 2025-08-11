import 'package:flutter/material.dart';
import '../../ds/theme/spacing.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.medium),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: Spacing.large),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleMedium),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle!, style: textTheme.bodyMedium),
                  ]
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: Spacing.large),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

