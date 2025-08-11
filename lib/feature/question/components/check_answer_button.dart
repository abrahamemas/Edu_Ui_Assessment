import 'package:flutter/material.dart';
import '../../../../ds/components/custom_button.dart';

class CheckAnswerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  
  const CheckAnswerButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Check The Answer',
      onPressed: onPressed,
      backgroundColor: const Color(0xFF67E7FF),
    );
  }
}


