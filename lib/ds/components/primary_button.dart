import 'package:flutter/material.dart';
import '../../ds/theme/colors.dart';
import '../../ds/theme/spacing.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool loading;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.loading = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorLight.colorPrimary,
        foregroundColor: Colors.black,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: Spacing.extraLarge, vertical: Spacing.medium),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600),
      ),
      child: loading
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.black)),
            )
          : Text(title),
    );
  }
}


