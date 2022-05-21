import 'dart:convert';

import 'package:equatable/equatable.dart';

BookingTable BookingTableFromJson(String str) => BookingTable.fromJson(json.decode(str));

String RestaurantToJson(BookingTable data) => json.encode(data.toJson());

class BookingTable extends Equatable {
  final int id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final int restaurantId;

  const BookingTable({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.restaurantId
  });

  @override
  List<Object?> get props => [id, title, subTitle, imageUrl, restaurantId];

   
  factory BookingTable.fromJson(Map<String, dynamic> json) => BookingTable(
    id: json["id"], 
    title: json["title"] ?? "", 
    subTitle: json["subTitle"] ?? "", 
    imageUrl: json["imageUrl"] ?? "",
    restaurantId: json["restaurantId"] ?? 0
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTitle": subTitle,
        "imageUrl": imageUrl,
        "restaurantId": restaurantId
      };
}