import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class BottomToolbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const BottomToolbar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavItemData(assetPath: 'assets/images/home_icon.png', label: 'Home'),
        BottomNavItemData(assetPath: 'assets/images/edu_icon_2.png', label: 'Topics'),
        BottomNavItemData(assetPath: 'assets/images/notes_icon_2.png', label: 'Practice'),
      ],
    );
  }
}