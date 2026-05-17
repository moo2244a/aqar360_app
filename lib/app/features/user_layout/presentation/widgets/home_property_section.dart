import 'package:aqar360/app/core/usecases/section_title.dart';
import 'package:flutter/material.dart';

class HomePropertySection extends StatelessWidget {
  final String title;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double height;

  const HomePropertySection({
    super.key,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
    this.height = 370,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        // ─── Section Title ───
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SectionTitle(title: title),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        // ─── PageView ───
        SliverToBoxAdapter(
          child: SizedBox(
            height: height,
            child: PageView.builder(
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 14)),
      ],
    );
  }
}

class MultiSliver extends StatelessWidget {
  final List<Widget> children;
  const MultiSliver({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: children);
  }
}
