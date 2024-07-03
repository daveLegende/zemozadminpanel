// events/authentication_event.dart
import 'package:admin/models/admin.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSuccessEvent extends AuthenticationEvent {
  final Admin admin;
  LoginSuccessEvent({required this.admin});

  @override
  List<Object> get props => [admin];
}

class LoginErrorEvent extends AuthenticationEvent {}

class LoginLoadingEvent extends AuthenticationEvent {}

class RegisterSuccessEvent extends AuthenticationEvent {
  final String email, password, confirm;
  RegisterSuccessEvent({
    required this.email,
    required this.password,
    required this.confirm,
  });

  @override
  List<Object> get props => [email, password, confirm];
}

class RegisterErrorEvent extends AuthenticationEvent {}

class RegisterLoadingEvent extends AuthenticationEvent {}

class IsAuthenticateEvent extends AuthenticationEvent {
  
}

class UnAuthenticateEvent extends AuthenticationEvent {
  UnAuthenticateEvent();

  @override
  List<Object?> get props => [];
}
