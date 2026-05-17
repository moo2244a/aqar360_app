import 'package:flutter/material.dart';

/// A Sliver section title used inside a [CustomScrollView].
class HomeSectionTitle extends StatelessWidget {
  final String title;

  const HomeSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
