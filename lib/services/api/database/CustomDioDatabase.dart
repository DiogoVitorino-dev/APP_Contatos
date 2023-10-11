import 'package:contatos_app/services/api/database/InterceptorDioDatabase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDioDatabase {
  final Dio _dio = Dio();

  CustomDioDatabase() {
    var baseUrl = dotenv.get("BASE_URL");

    if (baseUrl.isEmpty) {
      throw "MISSING BASE_URL VALUE AT ENVIRONMENT VARIABLES";
    }
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(InterceptorDioDatabase());
  }

  Dio get getInstance => _dio;
}
