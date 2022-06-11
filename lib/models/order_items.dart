import 'dart:convert';

import 'package:equatable/equatable.dart';

OrderItems OrderItemsFromJson(String str) => OrderItems.fromJson(json.decode(str));

String OrderItemsToJson(OrderItems data) => json.encode(data.toJson());

class OrderItems extends Equatable {
  final String foodName;
  final int price;
  final int psc;

  const OrderItems({
    required this.foodName,
    required this.price,
    required this.psc,
  });

  @override
  List<Object?> get props => [foodName, price, psc];

   
  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
    foodName: json["foodName"] ?? "", 
    price: json["price"] ?? 0, 
    psc: json["psc"] ?? 0, 
  );

  Map<String, dynamic> toJson() => {
        "foodName": foodName,
        "price": price,
        "psc": psc,
      };
}