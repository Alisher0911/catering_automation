part of 'localorganization_bloc.dart';

abstract class LocalOrganizationEvent extends Equatable {
  const LocalOrganizationEvent();

  @override
  List<Object> get props => [];
}



class LoadLocalOrganizations extends LocalOrganizationEvent {
  @override
  List<Object> get props => [];
}


class LoadLocalOrganizationsByGlobalId extends LocalOrganizationEvent {
  final int id;

  const LoadLocalOrganizationsByGlobalId({required this.id});

  @override
  List<Object> get props => [id];
}


class LoadLocalOrganizationById extends LocalOrganizationEvent {
  final int id;

  const LoadLocalOrganizationById({required this.id});

  @override
  List<Object> get props => [id];
}