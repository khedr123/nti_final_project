import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://accessories-eshop.runasp.net/api/auth/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
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
      print("API Raw Response: ${response.data}");
      return response;
    } on DioException catch (e) {
      print("DioException occurred!");
      print("🔸 Message: ${e.message}");
      print("🔸 Type: ${e.type}");
      print("🔸 Response data: ${e.response?.data}");
      print("🔸 Status code: ${e.response?.statusCode}");

      if (e.response != null) return e.response!;

      return Response(
        requestOptions: RequestOptions(path: 'login'),
        data: {
          "message": "Request failed: ${e.message}",
          "error": e.type.toString(),
        },
        statusCode: 400,
      );
    } catch (e) {
      print("Unexpected error: $e");
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
    } on DioException catch (e) {
      if (e.response != null) return e.response!;
      return Response(
        requestOptions: RequestOptions(path: 'verify-email'),
        data: {
          "message": "Request failed: ${e.message}",
          "error": e.type.toString(),
        },
        statusCode: 400,
      );
    } catch (e) {
      rethrow;
    }
  }
}
