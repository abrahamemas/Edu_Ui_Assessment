import 'package:flutter/material.dart';
import 'package:edu_ui_assessment/ds/components/avater.dart';
import 'package:edu_ui_assessment/ds/theme/spacing.dart';

class ScreenHeader extends StatelessWidget {
  final VoidCallback? onBack;
  final bool showBack;

  const ScreenHeader({super.key, this.onBack, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showBack)
          ClipOval(
            child: Material(
              color: const Color(0xFF2A2A2A),
              child: InkWell(
                onTap: onBack,
                child: const SizedBox(
                  width: Spacing.s56,
                  height: Spacing.s56,
                  child: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Color(0xFFF6F9F8),
                  ),
                ),
              ),
            ),
          )
        else
          const SizedBox(width: Spacing.s56, height: Spacing.s56),
        const Spacer(),
        Transform.translate(
          offset: Offset(15, 4),
          child: Avatar(assetPath: 'assets/images/avatar.png', size: Spacing.s64),
        ),
        const SizedBox(width: Spacing.small),
        Image.asset('assets/images/menu_2.png', width: Spacing.s56, height: Spacing.s56),
      ],
    );
  }
}




