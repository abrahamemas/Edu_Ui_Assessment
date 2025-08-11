import 'package:flutter/material.dart';
import 'package:edu_ui_assessment/ds/theme/colors.dart';
import 'package:edu_ui_assessment/ds/theme/radius.dart';
import 'package:edu_ui_assessment/ds/theme/spacing.dart';

class PressableTile extends StatelessWidget {
  final Color? backgroundColor;
  final String title;
  final String asset;
  final bool darkText;
  final Color? customTextColor;
  final VoidCallback? onTap;

  const PressableTile({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.asset,
    this.darkText = false,
    this.customTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: 1.0,
        child: Container(
          height: Spacing.s138,
          width: double.infinity,
          padding: const EdgeInsets.all(Spacing.extraLarge),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(Radii.r37),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                asset,
                width: 33,
                height: 33,
              ),
              const SizedBox(height: Spacing.large),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: customTextColor ?? (darkText ? Colors.white : ColorLight.darkBackground),
                      fontFamily: 'Outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


