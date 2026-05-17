import 'package:aqar360/app/features/search/presentation/cubit/search_cubit.dart';
import 'package:aqar360/app/features/search/presentation/cubit/search_state.dart';
import 'package:aqar360/app/features/search/presentation/widgets/empty_state.dart';
import 'package:aqar360/app/features/search/presentation/widgets/property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewPropertyCard extends StatelessWidget {
  const ListViewPropertyCard({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchEmpty) {
          return EmptyState(query: _searchController.text);
        }

        if (state is SearchSuccess) {
          final results = state.results;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            itemCount: results.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) => PropertyCard(property: results[i]),
          );
        }
        return SizedBox();
      },
    );
  }
}
