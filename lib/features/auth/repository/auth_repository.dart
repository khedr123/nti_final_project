import 'package:dio/dio.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService apiService;

  AuthRepository(this.apiService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Response response = await apiService.login(email, password);
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    final Response response = await apiService.verifyEmail(email, otp);
    return response.data ?? {};
  }
}
