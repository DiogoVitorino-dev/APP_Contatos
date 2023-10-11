import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDioCep {
  final Dio _dio = Dio();

  CustomDioCep() {
    var baseUrl = dotenv.get("VIACEP_URL");

    if (baseUrl.isEmpty) {
      throw "MISSING VIACEP_URL VALUE AT ENVIRONMENT VARIABLES";
    }
    _dio.options.baseUrl = baseUrl;
  }

  Dio get getInstance => _dio;
}
