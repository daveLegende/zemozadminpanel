// states/authentication_state.dart
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class LoginErrorState extends AuthenticationState {
  final String message;
  LoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginLoadingState extends AuthenticationState {}

class RegisterSuccessState extends AuthenticationState {}

class RegisterErrorState extends AuthenticationState {
  final String message;
  RegisterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterLoadingState extends AuthenticationState {}

class IsAuthenticateState extends AuthenticationState {
  final String token;
  IsAuthenticateState({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class UnAuthenticateStatate extends AuthenticationState {
  
}

class ErrorState extends AuthenticationState {
  final String errorMessage;

  ErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}