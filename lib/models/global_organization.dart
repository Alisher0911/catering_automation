import 'dart:convert';

import 'package:equatable/equatable.dart';


GlobalOrganization GlobalOrganizationFromJson(String str) => GlobalOrganization.fromJson(json.decode(str));

String GlobalOrganizationToJson(GlobalOrganization data) => json.encode(data.toJson());

class GlobalOrganization extends Equatable {
  final int id;
  final String name;
  final String description;
  final String urlImage;
  final List<int> foodTypes;
  final List<String> category;

  const GlobalOrganization({
    required this.id,
    required this.name,
    required this.description,
    required this.urlImage,
    this.foodTypes = const [1,2,3,4,5],
    required this.category
  });

  @override
  List<Object?> get props => [id, name, description, urlImage, foodTypes, category];

   
  factory GlobalOrganization.fromJson(Map<String, dynamic> json) => GlobalOrganization(
    id: json["id"], 
    name: json["name"] ?? "", 
    description: json["description"] ?? "", 
    urlImage: json["urlImage"] ?? "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    foodTypes: ((json["foodTypes"] ?? [1,2,3]) as List<dynamic>).cast<int>(),
    category: (json["category"] as List<dynamic>).cast<String>()
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "urlImage": urlImage,
        "foodTypes": foodTypes,
        "category": category
      };
}