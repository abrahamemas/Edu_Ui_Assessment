import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../shared/functions/platform.dart';

class PlatformScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? materialAppBar;
  final ObstructingPreferredSizeWidget? cupertinoNavBar;
  final Widget? bottomBar;

  const PlatformScaffold({
    super.key,
    required this.body,
    this.materialAppBar,
    this.cupertinoNavBar,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS()) {
      return CupertinoPageScaffold(
        navigationBar: cupertinoNavBar,
        child: body,
      );
    }
    return Scaffold(appBar: materialAppBar, body: body, bottomNavigationBar: bottomBar);
  }
}