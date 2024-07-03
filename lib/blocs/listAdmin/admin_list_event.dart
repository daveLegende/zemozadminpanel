part of 'admin_list_bloc.dart';

sealed class AdminListEvent extends Equatable {
  const AdminListEvent();

  @override
  List<Object> get props => [];
}

final class GetListAdminSuccessEvent extends AdminListEvent {}