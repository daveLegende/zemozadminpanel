part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

final class GetAdminSuccessEvent extends AdminEvent {}

final class GetAdminLoadingEvent extends AdminEvent {}

final class GetAdminErrorEvent extends AdminEvent {}