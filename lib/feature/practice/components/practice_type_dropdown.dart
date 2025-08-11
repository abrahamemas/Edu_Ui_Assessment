import 'package:flutter/material.dart';

class PracticeTypeDropdown extends StatelessWidget {
  const PracticeTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'type of question',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFA4A6A5),
                fontFamily: 'Outfit',
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.keyboard_arrow_down, color: Color(0xFFA4A6A5), size: 36),
      ],
    );
  }
}




