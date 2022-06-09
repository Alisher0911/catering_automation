part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}


class LoadGlobalOrganizations extends RestaurantEvent {
  @override
  List<Object> get props => [];
}

class LoadRestaurantTables extends RestaurantEvent {
  final int id;

  const LoadRestaurantTables({required this.id});

  @override
  List<Object> get props => [];
}