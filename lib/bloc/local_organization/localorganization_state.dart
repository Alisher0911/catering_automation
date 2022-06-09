part of 'localorganization_bloc.dart';

abstract class LocalOrganizationState extends Equatable {
  const LocalOrganizationState();
}




class LocalOrganiationsLoading extends LocalOrganizationState {
  @override
  List<Object> get props => [];
}


class LocalOrganizationsLoaded extends LocalOrganizationState {
  final List<LocalOrganization> localOrganizations;
  final List<Place> places;

  const LocalOrganizationsLoaded(this.localOrganizations, this.places);

  @override
  List<Object> get props => [localOrganizations, places];
}


class LocalOrganizationsError extends LocalOrganizationState {
  final String error;

  const LocalOrganizationsError(this.error);

  @override
  List<Object?> get props => [error];
}





class LocalOrganizationsByGlobalIdLoading extends LocalOrganizationState {
  @override
  List<Object> get props => [];
}


class LocalOrganizationsByGlobalIdLoaded extends LocalOrganizationState {
  final List<LocalOrganization> localOrganizations;

  const LocalOrganizationsByGlobalIdLoaded(this.localOrganizations);

  @override
  List<Object> get props => [localOrganizations];
}


class LocalOrganizationsByGlobalIdError extends LocalOrganizationState {
  final String error;

  const LocalOrganizationsByGlobalIdError(this.error);

  @override
  List<Object?> get props => [error];
}





class LocalOrganizationByIdLoading extends LocalOrganizationState {
  @override
  List<Object> get props => [];
}


class LocalOrganizationByIdLoaded extends LocalOrganizationState {
  final LocalOrganization localOrganization;
  final List<Category> categories;
  final List<FoodMenuItem> menuItems;

  const LocalOrganizationByIdLoaded(this.localOrganization, this.categories, this.menuItems);

  @override
  List<Object> get props => [localOrganization, categories];
}


class LocalOrganizationByIdError extends LocalOrganizationState {
  final String error;

  const LocalOrganizationByIdError(this.error);

  @override
  List<Object?> get props => [error];
}
