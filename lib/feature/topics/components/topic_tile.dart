import 'package:flutter/material.dart';

class TopicTile extends StatelessWidget {
  final String title;
  final String icon;
  final int count;
  final VoidCallback? onTap;
  
  const TopicTile({
    super.key, 
    required this.title, 
    required this.icon, 
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF232323),
          borderRadius: BorderRadius.circular(37),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF19E6B6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                icon,
                width: 28,
                height: 28,
                color: const Color(0xFF19E6B6),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontFamily: 'Outfit',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$count questions',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white70,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


