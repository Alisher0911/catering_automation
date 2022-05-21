import 'dart:convert';

import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final String category;
  final String description;
  final double price;

  const MenuItem(
      {required this.id,
      required this.restaurantId,
      required this.name,
      required this.category,
      required this.description,
      required this.price});

  @override
  List<Object?> get props => [id, restaurantId, name, category, description, price];


  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
      id: json['id'],
      restaurantId: json['restaurantId']?.toInt() ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
    );


  @override
  String toString() {
    return name;
  }

  static List<MenuItem> menuItems = [
    MenuItem(
      id: 1,
      restaurantId: 1,
      name: "Margherita", 
      category: "Pizza",
      description: "Tomatoes, mozzarella, basil",
      price: 4.99
    ),
    MenuItem(
      id: 2,
      restaurantId: 1,
      name: "4 Formaggi", 
      category: "Pizza",
      description: "Tomatoes, mozzarella, basil",
      price: 4.99
    ),
    MenuItem(
      id: 3,
      restaurantId: 1,
      name: "Baviera", 
      category: "Pizza",
      description: "Tomatoes, mozzarella, basil",
      price: 4.99
    ),
    MenuItem(
      id: 4,
      restaurantId: 1,
      name: "BBQ Chicken", 
      category: "Pizza",
      description: "BBQ sauce, chicken, cilantro, red onions, fontina cheese",
      price: 4.99
    ),
    MenuItem(
      id: 11,
      restaurantId: 1,
      name: "Coca Cola", 
      category: "Drinks",
      description: "Cold drink",
      price: 1.99
    ),
    MenuItem(
      id: 12,
      restaurantId: 1,
      name: "Fanta", 
      category: "Drinks",
      description: "A fresh drink",
      price: 1.99
    ),
  ];
  

  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
    };
  }
}
