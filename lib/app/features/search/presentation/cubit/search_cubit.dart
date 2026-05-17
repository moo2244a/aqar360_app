import 'package:aqar360/app/core/constants/app_list_property.dart';
import 'package:aqar360/app/core/constants/listing_type.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';

import 'package:aqar360/app/features/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  PropertyType selectedType = PropertyType.all;
  ListingType selectedListing = ListingType.all;
  double maxPrice = 10000000;

  static SearchCubit get(BuildContext context) =>
      BlocProvider.of<SearchCubit>(context);
  void updatePrice(double val) {
    maxPrice = val;
    return;
  }

  void setListing(ListingType listing) {
    selectedListing = listing;
    return;
  }

  void setType(PropertyType type) {
    selectedType = type;
    return;
  }

  void runSearch(String query) {
    final q = query.trim().toLowerCase();

    final List<PropertyDetails> allProps = [
      ...AppListProperty.villas,
      ...AppListProperty.apartments,
      ...AppListProperty.lands,
    ];

    emit(SearchLoading());

    final results = allProps.where((p) {
      // ── text filter ──
      if (q.isNotEmpty) {
        final titleMatch = (p.title ?? '').toLowerCase().contains(q);
        final locationMatch = (p.location ?? '').toLowerCase().contains(q);

        if (!titleMatch && !locationMatch) return false;
      }

      // ── type filter ──
      if (selectedType == PropertyType.villa && p is! VillaDetails) {
        return false;
      }
      if (selectedType == PropertyType.apartment && p is! ApartmentDetails) {
        return false;
      }
      if (selectedType == PropertyType.land && p is! LandDetails) {
        return false;
      }

      // ── listing filter ──
      if (selectedListing == ListingType.forSale && !p.isForSale) {
        return false;
      }
      if (selectedListing == ListingType.forRent && p.isForSale) {
        return false;
      }

      // ── price filter ──
      if ((p.price ?? 0) > maxPrice) return false;

      return true;
    }).toList();

    if (results.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchSuccess(results));
    }
  }
}
