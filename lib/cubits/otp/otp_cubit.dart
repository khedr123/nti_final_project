import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';
import '../../features/auth/data/services/otp_api_service.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpApiService otpApiService;

  OtpCubit(this.otpApiService) : super(OtpInitial());

  Future<void> validateOtp(String email, String otp) async {
    emit(OtpLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (otp.isNotEmpty) {
      print("Fake OTP accepted: $otp");
      emit(OtpSuccess(message: 'OTP verified successfully'));
    } else {
      emit(OtpError(message: 'Please enter OTP'));
    }
  }
}
