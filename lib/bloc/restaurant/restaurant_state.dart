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

  const RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantError extends RestaurantState {
  final String error;

  const RestaurantError(this.error);

  @override
  List<Object?> get props => [error];
}



class RestaurantTablesLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantTablesLoaded extends RestaurantState {
  final List<BookingTable> tables;

  const RestaurantTablesLoaded(this.tables);

  @override
  List<Object> get props => [tables];
}

class RestaurantTablesError extends RestaurantState {
  final String error;

  const RestaurantTablesError(this.error);

  @override
  List<Object?> get props => [error];
}