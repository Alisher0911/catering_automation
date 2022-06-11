import 'package:catering/config/constants.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/basket_model.dart';
import 'package:catering/models/menu_item_model.dart';
import 'package:catering/models/order_items.dart';
import 'package:catering/models/order_model.dart';
import 'package:dio/dio.dart';

class OrderRepository {

  final storage = SecureStorageService.getInstance;
  final _dio = Dio();


  Future<void> createOrder(Basket basket) async {
    var orderUrl = '$baseUrl/api/service/order/add';

    var tokenValue = await storage.read(key: 'token');
    var orgID = await storage.read(key: 'orgID');
    var address = await storage.read(key: "address");

    if (tokenValue != null && orgID != null || address != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        },
      );

      var menuItems = Map<String, dynamic>();
      basket.items.forEach((item) {
        if (!menuItems.containsKey(item.id.toString())) {
          menuItems[item.id.toString()] = 1;
        } else {
          menuItems[item.id.toString()] += 1;
        }
      });

      if (menuItems.isNotEmpty) {
        await _dio.post(orderUrl, options: dioOptions, data: {
          "address": address,
          "orgID": int.parse(orgID!),
          "totalCost": basket.total(basket.subtotal),
          "MenuItems": menuItems
        });
      }
    } else {
      throw Exception("Missing storage values");
    }
  }


  Future<List<Order>> getOrderHistoryList() async {
    var orderHistoryUrl = '$baseUrl/api/service/order/all';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        },
      );
      final response = await _dio.get(orderHistoryUrl, options: dioOptions);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => Order.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load order history");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<List<OrderItems>> getOrderItemsById(int id) async {
    var orderHistoryUrl = '$baseUrl/api/service/order/all/$id';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        },
      );
      final response = await _dio.get(orderHistoryUrl, options: dioOptions);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => OrderItems.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load order items");
      }
    } else {
      throw Exception("Token is missing");
    }
  }
}