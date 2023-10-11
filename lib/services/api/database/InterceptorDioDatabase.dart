import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InterceptorDioDatabase extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var appId = dotenv.get("APPLICATION_ID");
    var apiKey = dotenv.get("API_KEY");

    if (options.method == "GET" || options.method == "POST") {
      options.headers = {
        "X-Parse-Application-Id": appId,
        "X-Parse-REST-API-Key": apiKey,
        "Content-Type": "application/json"
      };
    } else {
      options.headers = {
        "X-Parse-Application-Id": appId,
        "X-Parse-REST-API-Key": apiKey,
      };
    }

    super.onRequest(options, handler);
  }
}
