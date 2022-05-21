part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterLoad extends FilterEvent {

  @override
  List<Object> get props => [];
}


class CategoryFilterUpdated extends FilterEvent {
  final CategoryFilter categoryFilter;

  CategoryFilterUpdated({required this.categoryFilter});

  @override
  List<Object> get props => [categoryFilter];
}


class PriceFilterUpdated extends FilterEvent {
  final PriceFilter priceFilter;

  PriceFilterUpdated({required this.priceFilter});

  @override
  List<Object> get props => [priceFilter];
}