import 'package:equatable/equatable.dart';

class FoodMenuItem extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String urlImage;
  final int listType;
  

  const FoodMenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.urlImage,
    required this.listType
  });

  @override
  List<Object?> get props => [id, title, description, price, urlImage, listType];


  factory FoodMenuItem.fromJson(Map<String, dynamic> json) => FoodMenuItem(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      urlImage: json['urlImage'] ?? 'https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/meal-food.png',
      listType: json['listType'] ?? 0,
    );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'urlImage': urlImage,
      'listType': listType,
    };
  }


  @override
  String toString() {
    return title;
  }

  // static List<MenuItem> menuItems = [
  //   MenuItem(
  //     id: 1,
  //     restaurantId: 1,
  //     name: "Margherita", 
  //     category: "Pizza",
  //     description: "Tomatoes, mozzarella, basil",
  //     price: 4.99
  //   ),
  //   MenuItem(
  //     id: 2,
  //     restaurantId: 1,
  //     name: "4 Formaggi", 
  //     category: "Pizza",
  //     description: "Tomatoes, mozzarella, basil",
  //     price: 4.99
  //   ),
  //   MenuItem(
  //     id: 3,
  //     restaurantId: 1,
  //     name: "Baviera", 
  //     category: "Pizza",
  //     description: "Tomatoes, mozzarella, basil",
  //     price: 4.99
  //   ),
  //   MenuItem(
  //     id: 4,
  //     restaurantId: 1,
  //     name: "BBQ Chicken", 
  //     category: "Pizza",
  //     description: "BBQ sauce, chicken, cilantro, red onions, fontina cheese",
  //     price: 4.99
  //   ),
  //   MenuItem(
  //     id: 11,
  //     restaurantId: 1,
  //     name: "Coca Cola", 
  //     category: "Drinks",
  //     description: "Cold drink",
  //     price: 1.99
  //   ),
  //   MenuItem(
  //     id: 12,
  //     restaurantId: 1,
  //     name: "Fanta", 
  //     category: "Drinks",
  //     description: "A fresh drink",
  //     price: 1.99
  //   ),
  // ];
}
