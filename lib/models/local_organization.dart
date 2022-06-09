import 'dart:convert';

import 'package:equatable/equatable.dart';


LocalOrganization LocalOrganizationFromJson(String str) => LocalOrganization.fromJson(json.decode(str));

String LocalOrganizationToJson(LocalOrganization data) => json.encode(data.toJson());

class LocalOrganization extends Equatable {
  final int id;
  final String name;
  final String address;
  final String urlImage;
  final int categoryID;
  final double rate;
  final int generalOrganizationID;

  const LocalOrganization({
    required this.id,
    required this.name,
    required this.address,
    required this.urlImage,
    required this.categoryID,
    required this.rate,
    required this.generalOrganizationID
  });

  @override
  List<Object?> get props => [id, name, address, urlImage, categoryID, rate, generalOrganizationID];

   
  factory LocalOrganization.fromJson(Map<String, dynamic> json) => LocalOrganization(
    id: json["id"], 
    name: json["name"] ?? "", 
    address: json["address"] ?? "", 
    urlImage: json["urlImage"] ?? "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    categoryID: json["categoryID"] ?? 0,
    rate: json["rate"] ?? 0.0,
    generalOrganizationID: json["generalOrganizationID"] ?? 0
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "urlImage": urlImage,
        "categoryID": categoryID,
        "rate" : rate,
        "generalOrganizationID": generalOrganizationID
      };
}