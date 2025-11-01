import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/repository/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;
  String? userEmail;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    userEmail = email;
    try {
      final response = await repository.login(email, password);
      print("🔹 Login Response: $response");

      if (response['statusCode'] == 200) {
        emit(LoginSuccess(response['message'] ?? "OTP sent to your email"));
      } else {
        emit(LoginError(response['message'] ?? "Login failed"));
      }
    } catch (e) {
      emit(LoginError("Connection error: $e"));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(LoginLoading());
    try {
      final response = await repository.verifyOtp(userEmail ?? "", otp);
      print("🔹 Verify Response: $response");

      if (response['statusCode'] == 200) {
        emit(LoginSuccess(response['message'] ?? "Email verified successfully"));
      } else {
        emit(LoginError(response['message'] ?? "Invalid or expired OTP"));
      }
    } catch (e) {
      emit(LoginError("Connection error: $e"));
    }
  }
}
