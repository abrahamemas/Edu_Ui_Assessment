import 'package:flutter/widgets.dart';

SliverToBoxAdapter sliverGap(double height) => SliverToBoxAdapter(child: SizedBox(height: height));

class SliverSafeArea extends StatelessWidget {
  final Widget sliver;
  final bool top;
  final bool bottom;
  const SliverSafeArea({super.key, required this.sliver, this.top = true, this.bottom = true});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: top ? MediaQuery.viewPaddingOf(context).top : 0,
        bottom: bottom ? MediaQuery.viewPaddingOf(context).bottom : 0,
      ),
      sliver: sliver,
    );
  }
}

