import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String query;

  const EmptyState({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: .3),
          ),
          const SizedBox(height: 16),
          Text(
            query.isEmpty
                ? AppStrings.noProperties
                : '${AppStrings.noResultsFor} "$query"',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: .5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
