import 'package:edu_ui_assessment/ds/components/avater.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                        color: const Color(0xFF070707),
                        fontFamily: 'Satoshi',
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
            Text('Alexandra!',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                        color: const Color(0xFF070707),
                        fontFamily: 'Satoshi',
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
          ],
        ),
        const Spacer(),
        Transform.translate(
          offset: Offset(15, 4),
          child: Avatar(assetPath: 'assets/images/avatar.png', size: 64),
        ),
        Image.asset('assets/images/menu_1.png', width: 56, height: 56),
      ],
    );
  }
}




