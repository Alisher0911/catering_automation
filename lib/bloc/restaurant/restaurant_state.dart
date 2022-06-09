part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}



class GlobalOrganizationLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class GlobalOrganizationLoaded extends RestaurantState {
  final List<GlobalOrganization> globalOrganizations;

  const GlobalOrganizationLoaded(this.globalOrganizations);

  @override
  List<Object> get props => [globalOrganizations];
}

class GlobalOrganizationError extends RestaurantState {
  final String error;

  const GlobalOrganizationError(this.error);

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