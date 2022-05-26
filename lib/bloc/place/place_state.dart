part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
  
  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}
