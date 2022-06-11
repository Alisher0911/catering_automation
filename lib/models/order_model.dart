import 'dart:convert';

import 'package:equatable/equatable.dart';

Order OrderFromJson(String str) => Order.fromJson(json.decode(str));

String OrderToJson(Order data) => json.encode(data.toJson());

class Order extends Equatable {
  final int id;
  final String address;
  final int orgID;
  final int userID;
  final int totalCost;

  const Order({
    required this.id,
    required this.address,
    required this.orgID,
    required this.userID,
    required this.totalCost,
  });

  @override
  List<Object?> get props => [id, address, orgID, userID, totalCost];

   
  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"], 
    address: json["address"] ?? "", 
    orgID: json["orgID"] ?? 0, 
    userID: json["userID"] ?? 0,
    totalCost: json["totalCost"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "orgID": orgID,
        "totalCost": totalCost,
        "userID": userID
      };
}