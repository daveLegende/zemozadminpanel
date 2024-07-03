part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class GetUserSuccessState extends UserState {
  final UserModel user;
  const GetUserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

final class GetUserLoadingState extends UserState {}

final class GetUserErrorState extends UserState {}

// 
final class GetListUsersSuccessState extends UserState {
  final List<UserModel> user;
  const GetListUsersSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

final class GetListUsersLoadingState extends UserState {}

final class GetListUsersErrorState extends UserState {}


final class UpdateUserFlutterState extends UserState {
  final UserModel user;
  final String sold;
  const UpdateUserFlutterState({required this.sold, required this.user});

  @override
  List<Object> get props => [sold];
}


final class UpdateUserSuccessState extends UserState {
  final UserModel user;
  const UpdateUserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

final class UpdateUserLoadingState extends UserState {}

final class UpdateUserErrorState extends UserState {}
