import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;
  String? userEmail;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    userEmail = email;

    try {
      final result = await repository.login(email, password);
      final statusCode = result["statusCode"];
      final data = result["data"];

      print("🔹 Login Full Data: $data");
      print("🔹 StatusCode: $statusCode");

      if (statusCode == 200 && data != null && data["accessToken"] != null) {
        emit(LoginSuccess(message: "Login successful", data: data));
      } else {
        emit(LoginError("Login failed \n${data?['message'] ?? 'Unknown error'}"));
      }
    } catch (e) {
      emit(LoginError("Connection error: $e"));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(LoginLoading());
    try {
      final response = await repository.verifyOtp(userEmail ?? "", otp);
      final statusCode = response["statusCode"];
      final data = response["data"];

      print("🔹 Verify Response: $data");

      if (statusCode == 200) {
        emit(LoginSuccess(message: "Email verified successfully"));
      } else {
        emit(LoginError("Invalid or expired OTP"));
      }
    } catch (e) {
      emit(LoginError("Connection error: $e"));
    }
  }
}
