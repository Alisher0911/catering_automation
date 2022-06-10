import 'package:bloc/bloc.dart';
import 'package:catering/models/basket_model.dart';
import 'package:catering/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc({
    required OrderRepository orderRepository
  }) : _orderRepository = orderRepository,
  super(OrderLoading()) {
    on<CreateOrder>(_onCreateOrder);
  }


  void _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      await _orderRepository.createOrder(event.basket);
      emit(OrderSuccess());
    } catch (error) {
      emit(OrderFailure(error: error.toString()));
    }
  }
}
