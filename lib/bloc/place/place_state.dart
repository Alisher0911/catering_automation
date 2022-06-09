part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
  
  @override
  List<Object> get props => [];
}

class PlaceByAddressLoading extends PlaceState {}

class PlaceByAddressLoaded extends PlaceState {
  final Location location;

    const PlaceByAddressLoaded({ required this.location });

  @override
  List<Object> get props => [location];
}


class MarkersInitial extends PlaceState {}

class MarkersLoaded extends PlaceState {
  final Set<Marker> mapMarkers;
  const MarkersLoaded({required this.mapMarkers});
}


class PlaceError extends PlaceState {}



class OrgMarkersInitial extends PlaceState {}

class OrgMarkersLoaded extends PlaceState {
  final List<Place> places;
  const OrgMarkersLoaded({required this.places});
}