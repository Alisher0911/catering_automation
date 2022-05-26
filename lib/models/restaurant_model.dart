import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'menu_item_model.dart';


Restaurant RestaurantFromJson(String str) => Restaurant.fromJson(json.decode(str));

String RestaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String address;
  final String imageUrl;
  final List<String> tags;
  final List<MenuItem> menuItems;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.tags,
    required this.menuItems,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance
  });

  @override
  List<Object?> get props => [id, name, address, imageUrl, tags, menuItems, deliveryTime, deliveryFee, distance];

   
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"], 
    name: json["name"] ?? "", 
    address: json["address"] ?? "", 
    imageUrl: json["imageUrl"] ?? "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    tags: (json["tags"] as List<dynamic>).cast<String>(),
    menuItems: (json["menuItems"] as List).map((i) => MenuItem.fromJson(i)).toList(),
    deliveryTime: json["deliveryTime"] ?? 0, 
    deliveryFee: json["deliveryFee"] ?? 0.0, 
    distance: json["distance"] ?? 0.0
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "imageUrl": imageUrl,
        "tags": tags,
        "menuItems": menuItems,
        "deliveryTime": deliveryTime,
        "deliveryFee": deliveryFee,
        "distance": distance
      };

  
  static List<Restaurant> restaurants = [
    Restaurant(
        id: 1,
        name: "The Chef",
        address: "st. Dostyk 13",
        imageUrl: "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        tags: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 1)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 1).toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),

    Restaurant(
        id: 2,
        name: "Fresco Italian Cafe",
        address: "st. Dostyk 13",
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b4/RESTAURANT.jpg",
        tags: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 2)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 2).toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),

    Restaurant(
        id: 3,
        name: "Brazilia Astana",
        address: "st. Dostyk 13",
        imageUrl: "https://images.pexels.com/photos/67468/pexels-photo-67468.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        tags: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 3)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 3).toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),

    Restaurant(
        id: 4,
        name: "Wall Street Restaurant & Bar",
        address: "st. Dostyk 13",
        imageUrl: "https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=800",
        tags: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 4)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 4).toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),

    Restaurant(
        id: 5,
        name: "Rixos",
        address: "st. Dostyk 13",
        imageUrl: "https://images.pexels.com/photos/941861/pexels-photo-941861.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        tags: MenuItem.menuItems
            .where((menuitem) => menuitem.restaurantId == 5)
            .map((menuitem) => menuitem.category)
            .toSet()
            .toList(),
        menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 5).toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
  ];
}


// class Restaurant extends Equatable {
//   final int id;
//   final String name;
//   final String imageUrl;
//   final List<String> tags;
//   final List<MenuItem> menuItems;
//   final String priceCategory;
//   final int deliveryTime;
//   final double deliveryFee;
//   final double distance;

//   Restaurant({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.tags,
//     required this.menuItems,
//     required this.priceCategory,
//     required this.deliveryTime,
//     required this.deliveryFee,
//     required this.distance
//   });

//   @override
//   List<Object?> get props => [id, name, imageUrl, tags, menuItems, priceCategory, deliveryTime, deliveryFee, distance];

//   static List<Restaurant> restaurants = [
//     Restaurant(
//         id: 1,
//         name: "The Chef",
//         imageUrl: "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
//         tags: MenuItem.menuItems
//             .where((menuitem) => menuitem.restaurantId == 1)
//             .map((menuitem) => menuitem.category)
//             .toSet()
//             .toList(),
//         menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 1).toList(),
//         priceCategory: '\$',
//         deliveryTime: 30,
//         deliveryFee: 2.99,
//         distance: 0.1),

//     Restaurant(
//         id: 2,
//         name: "Fresco Italian Cafe",
//         imageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b4/RESTAURANT.jpg",
//         tags: MenuItem.menuItems
//             .where((menuitem) => menuitem.restaurantId == 2)
//             .map((menuitem) => menuitem.category)
//             .toSet()
//             .toList(),
//         menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 2).toList(),
//         priceCategory: '\$',
//         deliveryTime: 30,
//         deliveryFee: 2.99,
//         distance: 0.1),

//     Restaurant(
//         id: 3,
//         name: "Brazilia Astana",
//         imageUrl: "https://images.pexels.com/photos/67468/pexels-photo-67468.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
//         tags: MenuItem.menuItems
//             .where((menuitem) => menuitem.restaurantId == 3)
//             .map((menuitem) => menuitem.category)
//             .toSet()
//             .toList(),
//         menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 3).toList(),
//         priceCategory: '\$',
//         deliveryTime: 30,
//         deliveryFee: 2.99,
//         distance: 0.1),

//     Restaurant(
//         id: 4,
//         name: "Wall Street Restaurant & Bar",
//         imageUrl: "https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=800",
//         tags: MenuItem.menuItems
//             .where((menuitem) => menuitem.restaurantId == 4)
//             .map((menuitem) => menuitem.category)
//             .toSet()
//             .toList(),
//         menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 4).toList(),
//         priceCategory: '\$',
//         deliveryTime: 30,
//         deliveryFee: 2.99,
//         distance: 0.1),

//     Restaurant(
//         id: 5,
//         name: "Rixos",
//         imageUrl: "https://images.pexels.com/photos/941861/pexels-photo-941861.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
//         tags: MenuItem.menuItems
//             .where((menuitem) => menuitem.restaurantId == 5)
//             .map((menuitem) => menuitem.category)
//             .toSet()
//             .toList(),
//         menuItems: MenuItem.menuItems.where((menuitem) => menuitem.restaurantId == 5).toList(),
//         priceCategory: '\$',
//         deliveryTime: 30,
//         deliveryFee: 2.99,
//         distance: 0.1),
//   ];
  
// }