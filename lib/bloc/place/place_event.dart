part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}


class LoadPlaceByAddress extends PlaceEvent {
  final String address;

  const LoadPlaceByAddress({required this.address});

  @override
  List<Object> get props => [address];
}

class LoadMarkers extends PlaceEvent {
  final List<Restaurant> restaurants;

  const LoadMarkers({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}