import 'package:catering/models/restaurant_model.dart';
import 'package:dio/dio.dart';

const String _baseUrl = "http://10.0.2.2:3000/restaurants";
// const String _baseUrl = "http://localhost:3000/restaurants";

class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants() async {
    var dio = Dio();
    final response = await dio.get(_baseUrl);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((x) => Restaurant.fromJson(x))
          .toList();
    } else {
      throw Exception("Failed to load restaurants");
    }
  }
}