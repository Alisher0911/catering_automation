import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final String address;
  final int orgID;
  final int totalCost;
  final Map menuItems;

  const Order({
    required this.id,
    required this.address,
    required this.orgID,
    required this.totalCost,
    required this.menuItems,
  });

  @override
  List<Object?> get props => [id, address, orgID, totalCost, menuItems];

   
  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"], 
    address: json["address"] ?? "", 
    orgID: json["orgID"] ?? 0, 
    totalCost: json["totalcost"] ?? 0,
    menuItems: json["MenuItems"] 
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "orgID": orgID,
        "totalCost": totalCost,
        "MenuItems" : menuItems,
      };
}