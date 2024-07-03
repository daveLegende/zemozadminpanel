part of 'transac_bloc.dart';

sealed class TransacEvent extends Equatable {
  const TransacEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTransacSuccessEvent extends TransacEvent {}
