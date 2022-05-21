import 'package:bloc/bloc.dart';
import 'package:catering/models/category_filter_model.dart';
import 'package:catering/models/filter_model.dart';
import 'package:catering/models/price_filter_model.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterLoading()) {
    on<FilterLoad>(_onFilterLoad);
    on<CategoryFilterUpdated>(_onCategoryFilterUpdated);
    on<PriceFilterUpdated>(_onPriceFilterUpdated);
  }


  void _onFilterLoad(FilterLoad event, Emitter<FilterState> emit) {
    emit(FilterLoaded(
      filter: Filter(
        categoryFilters: CategoryFilter.filters,
        priceFilters: PriceFilter.filters,
      ),
    ));
  }


  void _onCategoryFilterUpdated(CategoryFilterUpdated event, Emitter<FilterState> emit) {
    final state = this.state;
    if (state is FilterLoaded) {     
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();
      emit(FilterLoaded(
        filter: Filter(
          categoryFilters: updatedCategoryFilters,
          priceFilters: state.filter.priceFilters,
        ),
      ));
    }
  }


  void _onPriceFilterUpdated(PriceFilterUpdated event, Emitter<FilterState> emit) {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();
      emit(FilterLoaded(
        filter: Filter(
          categoryFilters: state.filter.categoryFilters,
          priceFilters: updatedPriceFilters,
        ),
      ));
    }
  }
}
