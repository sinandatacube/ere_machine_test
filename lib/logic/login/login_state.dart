part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {}

final class LoginChecking extends LoginState {}

final class LoginError extends LoginState {
  String error;
  LoginError({required this.error});
}
