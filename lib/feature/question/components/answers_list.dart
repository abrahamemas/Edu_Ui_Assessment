import 'package:flutter/material.dart';

class AnswersList extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;
  final int correctIndex;
  final bool showCorrectAnswer;
  final Function(int) onAnswerSelected;
  
  const AnswersList({
    super.key,
    required this.options,
    this.selectedIndex,
    required this.correctIndex,
    required this.showCorrectAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final isSelected = selectedIndex == i;
        final isCorrect = i == correctIndex;
        final showResult = showCorrectAnswer;
        
        Color borderColor = Colors.white.withValues(alpha: 0.1);
        Color backgroundColor = const Color(0xFF232323);
        
        if (showResult) {
          if (isCorrect) {
            borderColor = Colors.green;
            backgroundColor = Colors.green.withValues(alpha: 0.1);
          } else if (isSelected && !isCorrect) {
            borderColor = Colors.red;
            backgroundColor = Colors.red.withValues(alpha: 0.1);
          }
        } else if (isSelected) {
          borderColor = const Color(0xFF31F797);
          backgroundColor = const Color(0xFF31F797).withValues(alpha: 0.1);
        }

        return GestureDetector(
          onTap: () {
            // Toggle behavior: if already selected, deselect; otherwise select
            if (isSelected) {
              // Deselect by passing -1 (no selection)
              onAnswerSelected(-1);
            } else {
              // Select this answer
              onAnswerSelected(i);
            }
          },
          child: Container(
            height: 88,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(37),
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF31F797) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF31F797) : Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    options[i],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontFamily: 'Outfit',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


