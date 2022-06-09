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
  final List<LocalOrganization> localOrganizations;

  const LoadMarkers({required this.localOrganizations});

  @override
  List<Object> get props => [localOrganizations];
}


class LoadOrgMarkers extends PlaceEvent {
  final List<LocalOrganization> localOrganizations;
  const LoadOrgMarkers({required this.localOrganizations});
  @override
  List<Object> get props => [localOrganizations];
}