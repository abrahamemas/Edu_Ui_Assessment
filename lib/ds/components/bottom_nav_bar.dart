import 'package:flutter/material.dart';
import '../../ds/theme/spacing.dart';

class BottomNavItemData {
  final String assetPath;
  final String label;
  const BottomNavItemData({required this.assetPath, required this.label});
}

class BottomNavBar extends StatelessWidget {
  final List<BottomNavItemData> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color innerActiveBg = Color(0xFF232323);
    final Color activeAccent = Theme.of(context).colorScheme.primary;
    const Color inactiveIconBg = Color(0xFF232323);
    final Color inactiveIconColor =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);

    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: _horizontalPadding(context),
            right: _horizontalPadding(context),
            top: Spacing.large,
            bottom: Spacing.large,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < items.length; i++) ...[
                _BottomNavItem(
                  data: items[i],
                  isActive: i == currentIndex,
                  onTap: () => onTap(i),
                  activeAccent: activeAccent,
                  innerActiveBg: innerActiveBg,
                  inactiveIconBg: inactiveIconBg,
                  inactiveIconColor: inactiveIconColor,
                ),
                if (i != items.length - 1) const SizedBox(width: 4),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

double _horizontalPadding(BuildContext context) {
  final double width = MediaQuery.sizeOf(context).width;
  if (width <= 360) return 16;
  if (width <= 420) return 32;
  return 73;
}

class _BottomNavItem extends StatelessWidget {
  final BottomNavItemData data;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeAccent;
  final Color innerActiveBg;
  final Color inactiveIconBg;
  final Color inactiveIconColor;

  const _BottomNavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
    required this.activeAccent,
    required this.innerActiveBg,
    required this.inactiveIconBg,
    required this.inactiveIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  fontFamily: 'Outfit',
                  color: Colors.white,
                ) ??
            const TextStyle(
              fontSize: 12,
              fontFamily: 'Outfit',
              color: Colors.white,
            );

    if (!isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: inactiveIconBg.withValues(alpha: 0.8),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            data.assetPath,
            width: 24,
            height: 24,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 56,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.large,
          vertical: Spacing.small,
        ),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: innerActiveBg.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Expand only to content
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Image.asset(
                data.assetPath,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: Spacing.small),
            Flexible(
              child: Text(
                data.label,
                style: labelStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
