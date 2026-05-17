import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/search/presentation/cubit/search_cubit.dart';
import 'package:aqar360/app/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:aqar360/app/features/search/presentation/widgets/listing_chip_row.dart';
import 'package:aqar360/app/features/search/presentation/widgets/type_chip_row.dart';
import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatefulWidget {
  const SearchBarWithFilter({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  State<SearchBarWithFilter> createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(() {
      SearchCubit.get(context).runSearch(widget.searchController.text);
    });
  }

  void _showFilterSheet(String query, BuildContext context) {
    final cubit = SearchCubit.get(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
                top: 24,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Handle ──────────────────────────
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(ctx).dividerColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Property Type ────────────────────
                  Text(
                    AppStrings.sectionPropertyType,
                    style: Theme.of(ctx).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  TypeChipRow(
                    selected: cubit.selectedType,
                    onChanged: (v) => setSheetState(() {
                      cubit.setType(v);
                    }),
                  ),
                  const SizedBox(height: 20),

                  // ── Listing Type ─────────────────────
                  Text(
                    AppStrings.listingType,
                    style: Theme.of(ctx).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ListingChipRow(
                    selected: cubit.selectedListing,
                    onChanged: (v) => setSheetState(() {
                      cubit.setListing(v);
                    }),
                  ),

                  const SizedBox(height: 20),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.maxPrice,
                            style: Theme.of(ctx).textTheme.titleSmall,
                          ),
                          Text(
                            '${_formatPrice(cubit.maxPrice)} ${AppStrings.currency}',
                            style: Theme.of(ctx).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Slider(
                        value: cubit.maxPrice,
                        max: 10000000,
                        min: 0,
                        onChanged: (v) => setSheetState(() {
                          cubit.updatePrice(v);
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Apply button ─────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        cubit.runSearch(query);

                        Navigator.pop(ctx);
                      },
                      child: Text(AppStrings.applyFilter),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: CustomSearchBar(
        controller: widget.searchController,
        onFilterTap: (v) => _showFilterSheet(v, context),
      ),
    );
  }

  String _formatPrice(double v) {
    if (v >= 1000000) return 'م ${(v / 1000000).toStringAsFixed(1)}';
    if (v >= 1000) return 'ك ${(v / 1000).toStringAsFixed(0)} ';
    return v.toStringAsFixed(0);
  }
}
