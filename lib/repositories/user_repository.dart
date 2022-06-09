import 'package:catering/config/constants.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {

  final _dio = Dio();
  final storage = SecureStorageService.getInstance;


  Future<bool> hasToken() async {
    var value = await storage.read(key: "token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    var loginUrl = '$baseUrl/api/auth/signin';
    Response response = await _dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    return response.data["token"];
  }

  Future<void> register(String email, String username, String password, String confirmPassword) async {
    var registerUrl = '$baseUrl/api/auth/signup';
    await _dio.post(registerUrl, data: {
      "email": email,
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword
    });

    // return response.data["message"];
  }

  Future<UserData> getUserInformation() async {
    var userUrl = '$baseUrl/api/user';
    var tokenValue = await storage.read(key: 'token');
    if (tokenValue != null) {
      Options dioOptions = Options(
        headers: {
          "Authorization" : tokenValue
        }
      );
      final response = await _dio.get(userUrl, options: dioOptions);
      if (response.statusCode == 200) {
        return UserData.fromJson(response.data);
      } else {
        throw Exception("Failed to load user");
      }
    } else {
      throw Exception("Token is missing");
    }
  }
}