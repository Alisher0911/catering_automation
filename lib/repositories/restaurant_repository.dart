import 'package:catering/config/constants.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/booking_table_model.dart';
import 'package:catering/models/global_organization.dart';
import 'package:catering/models/local_organization.dart';
import 'package:catering/models/menu_item_model.dart';
import 'package:dio/dio.dart';


class RestaurantRepository {

  var dio = Dio();
  final storage = SecureStorageService.getInstance;

  Future<List<GlobalOrganization>> getGlobalOrganizations() async {
    var orgUrl = '$baseUrl/api/go/all';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await dio.get(orgUrl, options: dioOptions);
        if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => GlobalOrganization.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load global organizations");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<GlobalOrganization> getGlobalOrganizationById(int id) async {
    var orgUrl = '$baseUrl/api/go/$id';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await dio.get(orgUrl, options: dioOptions);
        if (response.statusCode == 200) {
        return GlobalOrganization.fromJson(response.data);
      } else {
        throw Exception("Failed to load global organization");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<List<LocalOrganization>> getLocalOrganizations() async {
    var orgUrl = '$baseUrl/api/lo/all';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await dio.get(orgUrl, options: dioOptions);
        if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => LocalOrganization.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load local organizations");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<List<LocalOrganization>> getLocalOrganizationsByGlobalId(int id) async {
    var orgUrl = '$baseUrl/api/lo/all/$id';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await dio.get(orgUrl, options: dioOptions);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => LocalOrganization.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load local organizations");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<LocalOrganization> getLocalOrganizationById(int id) async {
    var orgUrl = '$baseUrl/api/lo/$id';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await dio.get(orgUrl, options: dioOptions);
      if (response.statusCode == 200) {
        return LocalOrganization.fromJson(response.data);
      } else {
        throw Exception("Failed to load local organizations");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<List<FoodMenuItem>> getMenuItemsByGlobalId(int id) async {
    var menuUrl = '$baseUrl/api/food/all/$id';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await dio.get(menuUrl, options: dioOptions);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => FoodMenuItem.fromJson(x))
            .toList();
      } else {
        throw Exception("Failed to load menu items");
      }
    } else {
      throw Exception("Token is missing");
    }
  }


  Future<List<BookingTable>> getRestaurantTables(int id) async {
    final response = await dio.get(baseUrl + "/$id" + "/bookingTables");
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