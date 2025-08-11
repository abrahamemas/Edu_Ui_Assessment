import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../ds/theme/spacing.dart';

class HomeTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.extraLarge),
      child: Row(
        children: [
          Text('Hello', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(width: Spacing.small),
          Text('Abosede', style: Theme.of(context).textTheme.headlineSmall),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search))
        ],
      ),
    );
  }
}

