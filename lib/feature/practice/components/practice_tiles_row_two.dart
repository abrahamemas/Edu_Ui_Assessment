import 'package:flutter/material.dart';
import 'package:edu_ui_assessment/ds/components/pressable_tile.dart';

class PracticeTilesRowTwo extends StatefulWidget {
  final double tileWidth;
  final VoidCallback? onFirstTap;
  final VoidCallback? onSecondTap;
  
  const PracticeTilesRowTwo({
    super.key, 
    required this.tileWidth,
    this.onFirstTap,
    this.onSecondTap,
  });

  @override
  State<PracticeTilesRowTwo> createState() => _PracticeTilesRowTwoState();
}

class _PracticeTilesRowTwoState extends State<PracticeTilesRowTwo> {
  bool _firstTileTapped = false;
  bool _secondTileTapped = false;

  void _onFirstTap() {
    setState(() {
      _firstTileTapped = true;
    });
    widget.onFirstTap?.call();
    // Reset after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _firstTileTapped = false;
        });
      }
    });
  }

  void _onSecondTap() {
    setState(() {
      _secondTileTapped = true;
    });
    widget.onSecondTap?.call();
    // Reset after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _secondTileTapped = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: widget.tileWidth,
          child: PressableTile(
            backgroundColor: _firstTileTapped 
                ? const Color(0xFF31F797) 
                : const Color(0xFF232323),
            title: 'Topic',
            asset: 'assets/images/topic_icon.png',
            darkText: _firstTileTapped,
            customTextColor: const Color(0xFFF4F6F6),
            onTap: _onFirstTap,
          ),
        ),
        const SizedBox(width: 4),
        SizedBox(
          width: widget.tileWidth,
          child: PressableTile(
            backgroundColor: _secondTileTapped 
                ? const Color(0xFF31F797) 
                : const Color(0xFF232323),
            title: 'In a row',
            asset: 'assets/images/checklist.png',
            customTextColor: const Color(0xFFF4F6F6),
            darkText: _secondTileTapped,
            onTap: _onSecondTap,
          ),
        ),
      ],
    );
  }
}


