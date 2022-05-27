part of 'qr_bloc.dart';

abstract class QrState extends Equatable {
  const QrState();
  
  @override
  List<Object> get props => [];
}

class DataLoading extends QrState {}

class DataLoaded extends QrState {
  final String data;

  const DataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataLoadingError extends QrState {
  final String error;

  const DataLoadingError(this.error);

  @override
  List<Object> get props => [error];
}
