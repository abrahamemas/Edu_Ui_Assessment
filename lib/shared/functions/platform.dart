import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isIOS() => Platform.isIOS;

Route<T> platformRoute<T>(Widget page) {
  return isIOS()
      ? CupertinoPageRoute<T>(builder: (_) => page)
      : MaterialPageRoute<T>(builder: (_) => page);
}

ScrollPhysics platformScrollPhysics(BuildContext _) =>
    isIOS() ? const BouncingScrollPhysics() : const ClampingScrollPhysics();