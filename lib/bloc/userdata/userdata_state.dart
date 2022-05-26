part of 'userdata_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
  
  @override
  List<Object> get props => [];
}


class UserDataLoading extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoaded extends UserDataState {
  final UserData user;

  const UserDataLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserDataError extends UserDataState {
  final String error;

  const UserDataError(this.error);

  @override
  List<Object> get props => [error];
}