import 'package:catering/models/delivery_time_model.dart';
import 'package:catering/models/menu_item_model.dart';
import 'package:catering/models/voucher_model.dart';
import 'package:equatable/equatable.dart';

class Basket extends Equatable {
  final List<FoodMenuItem> items;
  final bool cutlery;
  final Voucher? voucher;
  final DeliveryTime? deliveryTime;

  Basket({
    this.items = const <FoodMenuItem>[],
    this.cutlery = false,
    this.voucher,
    this.deliveryTime
  });

  Basket copyWith({
    List<FoodMenuItem>? items,
    bool? cutlery,
    Voucher? voucher,
    DeliveryTime? deliveryTime
  }) {
    return Basket(
      items: items ?? this.items,
      cutlery: cutlery ?? this.cutlery,
      voucher: voucher ?? this.voucher,
      deliveryTime: deliveryTime ?? this.deliveryTime
    );
  }


  @override
  List<Object?> get props => [items, cutlery, voucher, deliveryTime];
  
  Map itemQuantity(items) {
    var quantity = Map();
    
    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    
    return quantity;
  }

  double get subtotal => items.fold(0, (total, current) => total + current.price);

  String get numberOfItmems => items.length.toString();

  double total(subtotal) {
    return (voucher == null) ? subtotal + 500 : subtotal + 500 - voucher!.value;
  }

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal).toStringAsFixed(2);
}