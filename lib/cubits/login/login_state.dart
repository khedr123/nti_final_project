abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final Map<String, dynamic>? data;
  LoginSuccess({required this.message, this.data});
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}
