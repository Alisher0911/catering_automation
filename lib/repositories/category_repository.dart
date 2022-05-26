import 'package:catering/config/constants.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoryRepository {
  CategoryRepository();

  var dio = Dio();
  final storage = SecureStorageService.getInstance;

  Future<List<Category>> getCategories() async {
    var token = await storage.read(key: "token");
    if (token != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : token
        }
      );
      final response = await dio.get("$baseUrl/api/food/type/", options: dioOptions);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => Category.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } else {
      throw Exception("Token is missing");
    }
  }
}