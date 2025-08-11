import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  
  const CustomButton({
    super.key, 
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final buttonColor = backgroundColor ?? const Color(0xFF67E7FF);
    final buttonTextColor = textColor ?? Colors.black;
    
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            height: height ?? 58,
            width: width ?? 196,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            decoration: BoxDecoration(
              color: isEnabled 
                  ? buttonColor
                  : buttonColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isEnabled ? buttonTextColor : buttonTextColor.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
