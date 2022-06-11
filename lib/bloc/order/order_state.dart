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



class OrderHistoryLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderHistoryLoaded extends OrderState {
  final List<Order> orders;

  const OrderHistoryLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderHistoryFailure extends OrderState {
  final String error;

  const OrderHistoryFailure(this.error);

  @override
  List<Object> get props => [error];
}




class OrderItemsLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderItemsLoaded extends OrderState {
  final List<OrderItems> orderItems;

  const OrderItemsLoaded(this.orderItems);

  @override
  List<Object> get props => [orderItems];
}

class OrderItemsFailure extends OrderState {
  final String error;

  const OrderItemsFailure(this.error);

  @override
  List<Object> get props => [error];
}