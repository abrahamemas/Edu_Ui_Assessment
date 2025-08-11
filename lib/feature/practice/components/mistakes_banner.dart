import 'package:flutter/material.dart';

class MistakesBanner extends StatelessWidget {
  const MistakesBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 132,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF67E7FF),
        borderRadius: BorderRadius.circular(37),
       
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Mistakes practice',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF000708),
                      fontFamily: 'Outfit',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Practice more the very exam exercise which you're doing worse. You're gonna deal with it",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF005F77),
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}


