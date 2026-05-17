import 'package:aqar360/app/features/search/presentation/cubit/search_cubit.dart';

import 'package:aqar360/app/features/search/presentation/widgets/list_view_property_card.dart';

import 'package:aqar360/app/features/search/presentation/widgets/search_bar_with_filter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit()..runSearch(""),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leadingWidth: 0,
          title: SearchBarWithFilter(searchController: _searchController),
        ),
        body: ListViewPropertyCard(searchController: _searchController),
      ),
    );
  }
}
