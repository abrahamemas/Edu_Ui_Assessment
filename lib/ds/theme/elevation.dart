import 'package:flutter/material.dart';

class Elevation {
  static const List<BoxShadow> none = [];
  static const List<BoxShadow> level1 = [
    BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 4)),
  ];
    static const List<BoxShadow> level2 = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 8)),
  ];
  static const List<BoxShadow> level3 = [
    BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, 12)),
  ];
}

