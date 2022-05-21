part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}


class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}


class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}


class RestaurantError extends RestaurantState {
  final String error;

  RestaurantError(this.error);

  @override
  List<Object?> get props => [error];
}