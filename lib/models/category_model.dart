import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

Category CategoryFromJson(String str) => Category.fromJson(json.decode(str));

String CategoryToJson(Category data) => json.encode(data.toJson());

class Category extends Equatable {
  final int id;
  final String name;
  final String urlImage;

  Category({required this.id, required this.name, required this.urlImage});

  @override
  List<Object?> get props => [id, name, urlImage];


  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"], 
    name: json["name"] ?? "", 
    urlImage: json["urlImage"] ?? "https://cdn-icons-png.flaticon.com/512/3132/3132693.png",
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "urlImage": urlImage,
      };

  // static List<Category> categories = [
  //   Category(id: 1, name: "Pizza", urlImage: Image.asset('assets/pizza.png')),
  //   Category(id: 2, name: "Burger", urlImage: Image.asset('assets/burger.png')),
  //   Category(id: 3, name: "Salad", urlImage: Image.asset('assets/salad.png')),
  //   Category(id: 4, name: "Dessert", urlImage: Image.asset('assets/dessert.png')),
  //   Category(id: 5, name: "Drink", urlImage: Image.asset('assets/drink.png')),
  // ];
  static List<Category> categories = [
    Category(id: 1, name: "Pizza", urlImage: "https://cdn-icons-png.flaticon.com/512/3132/3132693.png"),
    Category(id: 2, name: "Burger", urlImage: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png'),
    Category(id: 3, name: "Salad", urlImage: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png'),
    Category(id: 4, name: "Dessert", urlImage: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png'),
    Category(id: 5, name: "Drink", urlImage: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png'),
  ];
}