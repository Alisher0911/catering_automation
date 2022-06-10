part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}


class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderSuccess extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderFailure extends OrderState {
  final String error;

  const OrderFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OrderFailure { error: $error }';
}
