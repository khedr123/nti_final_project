import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "https://accessories-eshop.runasp.net/api/auth/"),
  );

  Future<Response> login(String email, String password) async {
    try {
      final response = await dio.post(
        'login',
        data: {
          "email": email,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        return e.response ?? Response(requestOptions: RequestOptions());
      }
      rethrow;
    }
  }

  Future<Response> verifyEmail(String email, String otp) async {
    try {
      final response = await dio.post(
        'verify-email',
        data: {
          "email": email,
          "otp": otp,
        },
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        return e.response ?? Response(requestOptions: RequestOptions());
      }
      rethrow;
    }
  }
}


