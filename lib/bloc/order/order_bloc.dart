import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/basket_model.dart';
import 'package:catering/models/order_items.dart';
import 'package:catering/models/order_model.dart';
import 'package:catering/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  final BasketBloc _basketBloc;
  StreamSubscription? _orderSubscription;
  final storage = SecureStorageService.getInstance;

  OrderBloc({
    required OrderRepository orderRepository,
    required BasketBloc basketBloc
  }) : _orderRepository = orderRepository,
        _basketBloc = basketBloc,
        super(OrderLoading()) {
          on<CreateOrder>(_onCreateOrder);
          on<LoadOrderHisory>(_onLoadOrderHisory);
          on<LoadOrderItems>(_onLoadOrderItems);
        }


  void _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        await _orderRepository.createOrder(event.basket);
        _basketBloc.add(ClearBasket());
        emit(OrderSuccess());
      } else {
        emit(OrderFailure(error: "No token"));
      }
    } catch (error) {
      emit(OrderFailure(error: error.toString()));
    }
  }

  void _onLoadOrderHisory(LoadOrderHisory event, Emitter<OrderState> emit) async {
    _orderSubscription?.cancel();
    emit(OrderHistoryLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final orders = await _orderRepository.getOrderHistoryList();
        emit(OrderHistoryLoaded(orders));
      } else {
        emit(OrderHistoryFailure("No token"));
      }
    } catch(e) {
      emit(OrderHistoryFailure(e.toString()));
    }
  }

  void _onLoadOrderItems(LoadOrderItems event, Emitter<OrderState> emit) async {
    _orderSubscription?.cancel();
    emit(OrderItemsLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final orderItems = await _orderRepository.getOrderItemsById(event.id);
        emit(OrderItemsLoaded(orderItems));
      } else {
        emit(OrderItemsFailure("No token"));
      }
    } catch(e) {
      emit(OrderItemsFailure(e.toString()));
    }
  }


  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
