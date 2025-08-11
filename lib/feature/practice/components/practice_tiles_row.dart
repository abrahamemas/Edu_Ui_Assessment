import 'package:flutter/material.dart';
import 'package:edu_ui_assessment/ds/components/pressable_tile.dart';

class PracticeTilesRow extends StatefulWidget {
  final double tileWidth;
  final VoidCallback? onFirstTap;
  final VoidCallback? onSecondTap;
  
  const PracticeTilesRow({
    super.key, 
    required this.tileWidth, 
    this.onFirstTap,
    this.onSecondTap,
  });

  @override
  State<PracticeTilesRow> createState() => _PracticeTilesRowState();
}

class _PracticeTilesRowState extends State<PracticeTilesRow> {
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
                : const Color(0xFF31F797),
            title: 'Random',
            asset: 'assets/images/random_icon.png',
            darkText: _firstTileTapped,
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
            title: 'Exam Number',
            asset: 'assets/images/Icon_tag.png',
            darkText: _secondTileTapped,
            customTextColor: const Color(0xFFF4F6F6),
            onTap: _onSecondTap,
          ),
        ),
      ],
    );
  }
}


