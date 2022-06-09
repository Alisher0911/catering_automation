import 'package:dio/dio.dart';

class DioService {

  static final DioService _instance = DioService._internal();
  late Dio dio;

  DioService._internal() {
    dio = Dio();
  }
  
  static DioService get getInstance => _instance;
}