part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvent {
  final Basket basket;

  const CreateOrder(this.basket);

  @override
  List<Object> get props => [basket];
}


class LoadOrderHisory extends OrderEvent {
  @override
  List<Object> get props => [];
}

class LoadOrderItems extends OrderEvent {
  final int id;

  const LoadOrderItems(this.id);

  @override
  List<Object> get props => [];
}