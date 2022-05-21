import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menuitemquantity_state.dart';

class MenuItemQuantityCubit extends Cubit<MenuItemQuantityState> {
  MenuItemQuantityCubit() : super(MenuItemQuantityState(quantity: 1));

  
  void increment() => emit(MenuItemQuantityState(quantity: state.quantity + 1));

  void decrement() {
    if (state.quantity > 1) {
      emit(MenuItemQuantityState(quantity: state.quantity - 1));
    }
  }

  void refreshQuantity() => emit(MenuItemQuantityState(quantity: 1));
}
