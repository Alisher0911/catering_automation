import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/booking_table_model.dart';
import 'package:catering/models/global_organization.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final  RestaurantRepository _restaurantRepository;
  final PlaceBloc placeBloc;
  StreamSubscription? _restaurantSubscription;
  final storage = SecureStorageService.getInstance;

  RestaurantBloc({
    required RestaurantRepository restaurantRepository,
    required this.placeBloc
  }) : _restaurantRepository = restaurantRepository,
    super(GlobalOrganizationLoading()) {
      on<LoadRestaurantTables>(_onLoadRestaurantTables);
      on<LoadGlobalOrganizations>(_onLoadGlobalOrganizations);
    }


  void _onLoadGlobalOrganizations(LoadGlobalOrganizations event, Emitter<RestaurantState> emit) async {
    _restaurantSubscription?.cancel();
    emit(GlobalOrganizationLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final globalOrganizations = await _restaurantRepository.getGlobalOrganizations();
        emit(GlobalOrganizationLoaded(globalOrganizations));
      } else {
        emit(GlobalOrganizationError("No token"));
      }
    } catch(e) {
      emit(GlobalOrganizationError(e.toString()));
    }
  }


  void _onLoadRestaurantTables(LoadRestaurantTables event, Emitter<RestaurantState> emit) async {
    _restaurantSubscription?.cancel();
    emit(RestaurantTablesLoading());
    try {
      final tables = await _restaurantRepository.getRestaurantTables(event.id);
      emit(RestaurantTablesLoaded(tables));
    } catch(e) {
      emit(RestaurantTablesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _restaurantSubscription?.cancel();
    return super.close();
  }
}
