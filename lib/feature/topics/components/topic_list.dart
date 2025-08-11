import 'package:flutter/material.dart';

class TopicList extends StatelessWidget {
  final List<TopicItem> topics;
  const TopicList({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: topics.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (_, i) {
        final t = topics[i];
        return Container(
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
                  t.icon,
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
                      t.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${t.count} questions',
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
        );
      },
    );
  }
}

class TopicItem {
  final String title;
  final String icon;
  final int count;
  const TopicItem(this.title, this.icon, this.count);
}


