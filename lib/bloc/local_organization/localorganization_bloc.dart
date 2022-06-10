import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/category_model.dart';
import 'package:catering/models/local_organization.dart';
import 'package:catering/models/menu_item_model.dart';
import 'package:catering/models/place.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:equatable/equatable.dart';

part 'localorganization_event.dart';
part 'localorganization_state.dart';

class LocalOrganizationBloc extends Bloc<LocalOrganizationEvent, LocalOrganizationState> {
  final RestaurantRepository _restaurantRepository;
  final CategoryRepository _categoryRepository;
  final GeolocationRepository _geolocationRepository;
  final PlaceBloc placeBloc;
  StreamSubscription? _orgSubscription;
  final storage = SecureStorageService.getInstance;

  LocalOrganizationBloc({
    required RestaurantRepository restaurantRepository,
    required CategoryRepository categoryRepository,
    required GeolocationRepository geolocationRepository,
    required this.placeBloc,
  }) : _restaurantRepository = restaurantRepository,
        _categoryRepository = categoryRepository,
        _geolocationRepository = geolocationRepository,
        super(LocalOrganizationsByGlobalIdLoading()) {
          on<LoadLocalOrganizations>(_onLoadLocalOrganizations);
          on<LoadLocalOrganizationsByGlobalId>(_onLoadLocalOrganizationByGlobalId);
          on<LoadLocalOrganizationById>(_onLoadLocalOrganizationById);
        }



  void _onLoadLocalOrganizations(LoadLocalOrganizations event, Emitter<LocalOrganizationState> emit) async {
    _orgSubscription?.cancel();
    emit(LocalOrganiationsLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final localOrganizations = await _restaurantRepository.getLocalOrganizations();
        final List<Place> places = await _geolocationRepository.getLocationsOfOrganizations(localOrganizations);
        // placeBloc.add(LoadOrgMarkers(localOrganizations: localOrganizations));
        emit(LocalOrganizationsLoaded(localOrganizations, places));
      } else {
        emit(LocalOrganizationsError("No token"));
      }
    } catch(e) {
      emit(LocalOrganizationsError(e.toString()));
    }
  }


  void _onLoadLocalOrganizationByGlobalId(LoadLocalOrganizationsByGlobalId event, Emitter<LocalOrganizationState> emit) async {
    _orgSubscription?.cancel();
    emit(LocalOrganizationsByGlobalIdLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final localOrganizations = await _restaurantRepository.getLocalOrganizationsByGlobalId(event.id);
        emit(LocalOrganizationsByGlobalIdLoaded(localOrganizations));
      } else {
        emit(LocalOrganizationsByGlobalIdError("No token"));
      }
    } catch(e) {
      emit(LocalOrganizationsByGlobalIdError(e.toString()));
    }
  }


  void _onLoadLocalOrganizationById(LoadLocalOrganizationById event, Emitter<LocalOrganizationState> emit) async {
    _orgSubscription?.cancel();
    emit(LocalOrganizationByIdLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final localOrganization = await _restaurantRepository.getLocalOrganizationById(event.id);
        final globalOrganization = await _restaurantRepository.getGlobalOrganizationById(localOrganization.generalOrganizationID);
        storage.write(key: "orgID", value: globalOrganization.id.toString());
        storage.write(key: "address", value: localOrganization.address);

        final categories = await _categoryRepository.getCategories();
        final globalOrganizationCategories = categories.where((category) => globalOrganization.foodTypes.contains(category.id)).toList();

        final menuItems = await _restaurantRepository.getMenuItemsByGlobalId(globalOrganization.id);

        emit(LocalOrganizationByIdLoaded(localOrganization, globalOrganizationCategories, menuItems));
      } else {
        emit(LocalOrganizationByIdError("No token"));
      }
    } catch(e) {
      emit(LocalOrganizationByIdError(e.toString()));
    }
  }


  @override
  Future<void> close() {
    _orgSubscription?.cancel();
    return super.close();
  }
}
