import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<PropertyDetails> results;

  SearchSuccess(this.results);
}

class SearchEmpty extends SearchState {}

class SearchFilterUpdated extends SearchState {}
