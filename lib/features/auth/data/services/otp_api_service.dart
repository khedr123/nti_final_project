import 'package:dio/dio.dart';

class OtpApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://accessories-eshop.runasp.net/api/auth",
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> validateOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/validate-otp',
        data: {
          "email": email,
          "otp": otp,
        },
      );

      print("OTP API Response: ${response.data}");
      return {
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } on DioException catch (e) {
      print("OTP API Error: ${e.response?.data ?? e.message}");
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'data': e.response?.data ??
            {'message': 'Unknown error occurred while validating OTP'},
      };
    }
  }
}
