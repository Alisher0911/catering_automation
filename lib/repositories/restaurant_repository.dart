import 'package:catering/config/constants.dart';
import 'package:catering/models/booking_table_model.dart';
import 'package:catering/models/restaurant_model.dart';
import 'package:dio/dio.dart';

// const String _baseUrl = "http://10.0.2.2:3000/restaurants";
const String _restUrl = "$jsonUrl/restaurants";

class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants() async {
    var dio = Dio();
    final response = await dio.get(_restUrl);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((x) => Restaurant.fromJson(x))
          .toList();
    } else {
      throw Exception("Failed to load restaurants");
    }
  }

  Future<List<BookingTable>> getRestaurantTables(int id) async {
    var dio = Dio();
    final response = await dio.get(_restUrl + "/$id" + "/bookingTables");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((x) => BookingTable.fromJson(x))
          .toList()
          ..sort((a, b) => a.subTitle.compareTo(b.subTitle));
    } else {
      throw Exception("Failed to load restaurants");
    }
  }
}