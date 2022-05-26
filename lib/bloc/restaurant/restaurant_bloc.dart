import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/models/booking_table_model.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final  RestaurantRepository _restaurantRepository;
  StreamSubscription? _restaurantSubscription;

  RestaurantBloc({required RestaurantRepository restaurantRepository}) 
    : _restaurantRepository = restaurantRepository,
    super(RestaurantLoading()) {
      on<LoadRestaurants>(_onLoadRestaurants);
      on<LoadRestaurantTables>(_onLoadRestaurantTables);
    }


  void _onLoadRestaurants(LoadRestaurants event, Emitter<RestaurantState> emit) async {
    _restaurantSubscription?.cancel();
    emit(RestaurantLoading());
    try {
      final restaurants = await _restaurantRepository.getRestaurants();
      emit(RestaurantLoaded(restaurants));
    } catch(e) {
      emit(RestaurantError(e.toString()));
    }
  }

  void _onLoadRestaurantTables(LoadRestaurantTables event, Emitter<RestaurantState> emit) async {
    _restaurantSubscription?.cancel();
    emit(RestaurantTablesLoading());
    try {
      final tables = await _restaurantRepository.getRestaurantTables(event.id);
      emit(RestaurantTablesLoaded(tables));
    } catch(e) {
      emit(RestaurantError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _restaurantSubscription?.cancel();
    return super.close();
  }
}
