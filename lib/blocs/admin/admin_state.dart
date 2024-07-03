part of 'admin_bloc.dart';

sealed class AdminState extends Equatable {
  const AdminState();
  
  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

final class GetAdminSuccessState extends AdminState {
  final Admin admin;
  const GetAdminSuccessState({required this.admin});

  @override
  List<Object> get props => [admin];
}

final class GetAdminLoadingState extends AdminState {}

final class GetAdminErrorState extends AdminState {}
