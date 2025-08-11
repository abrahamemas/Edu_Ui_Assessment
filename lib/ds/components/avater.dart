import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String assetPath;
  final double size;
  const Avatar({super.key, required this.assetPath, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.asset(assetPath, width: size, height: size, fit: BoxFit.cover),
    );
  }
}


