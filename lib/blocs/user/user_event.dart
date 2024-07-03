part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class UserInitialEvent extends UserEvent {}

final class GetUserSuccessEvent extends UserEvent {}

final class GetUserLoadingEvent extends UserEvent {}

final class GetUserErrorEvent extends UserEvent {}

// 
final class GetListUsersSuccessEvent extends UserEvent {}

final class GetListUsersLoadingEvent extends UserEvent {}

final class GetListUsersErrorEvent extends UserEvent {}

final class UpdateUserFlutterEvent extends UserEvent {
  final UserModel? user;
  final String sold;
  final String? groupe;
  final double standardSold, vipSolde;
  const UpdateUserFlutterEvent({
    required this.sold,
    this.groupe,
    this.user,
    required this.vipSolde,
    required this.standardSold,
  });

  @override
  List<Object> get props => [sold, vipSolde, standardSold];
}

final class UpdateUserSuccessEvent extends UserEvent {}

final class UpdateUserLoadingEvent extends UserEvent {}

final class UpdateUserErrorEvent extends UserEvent {}
