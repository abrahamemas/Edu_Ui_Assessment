import 'package:flutter/material.dart';
import '../../ds/theme/colors.dart';
import '../../ds/theme/radius.dart';
import '../../ds/theme/spacing.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const AppChip({super.key, required this.label, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color bg = selected ? ColorLight.colorPrimary : Theme.of(context).colorScheme.surface;
    final Color fg = selected ? Colors.black : Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.large, vertical: Spacing.small),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.all(Radius.circular(Radii.r28)),
        ),
        child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: fg)),
      ),
    );
  }
}

