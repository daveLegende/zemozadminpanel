part of 'transac_bloc.dart';

sealed class TransacState extends Equatable {
  const TransacState();

  @override
  List<Object> get props => [];
}

final class TransacInitial extends TransacState {}

final class GetAllTransacLoadingState extends TransacState {}

final class GetAllTransacSuccessState extends TransacState {
  final List<TransactionModel> transacs;
  const GetAllTransacSuccessState({
    required this.transacs,
  });

  @override
  List<Object> get props => [transacs];
}

final class GetAllTransacErrorState extends TransacState {}
