part of 'admin_list_bloc.dart';

sealed class AdminListState extends Equatable {
  const AdminListState();
  
  @override
  List<Object> get props => [];
}

final class AdminListInitial extends AdminListState {}

final class GetListAdminSuccessState extends AdminListState {
  final List<Admin> admins;
  const GetListAdminSuccessState({required this.admins});

  @override
  List<Object> get props => [admins];
}

final class GetListAdminLoadingState extends AdminListState {}

final class GetListAdminErrorState extends AdminListState {}
