import 'package:flutter/material.dart';
import 'package:edu_ui_assessment/ds/components/avater.dart';
import 'package:edu_ui_assessment/ds/theme/spacing.dart';

class SecondScreenHeader extends StatelessWidget {
  final VoidCallback? onBack;
  final bool showBack;

  const SecondScreenHeader({super.key, this.onBack, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showBack)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Practice',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Color(0xFFA8ABAA),
                      fontFamily: 'Outfit',
                      fontSize: 32,
                      fontWeight: FontWeight.w400)),
            ],
          )
        else
          const SizedBox(width: Spacing.s56, height: Spacing.s56),
        const Spacer(),
        Transform.translate(
          offset: Offset(15, 4),
          child:
              Avatar(assetPath: 'assets/images/avatar.png', size: Spacing.s64),
        ),
        const SizedBox(width: Spacing.small),
        Image.asset('assets/images/menu_2.png',
            width: Spacing.s56, height: Spacing.s56),
      ],
    );
  }
}
