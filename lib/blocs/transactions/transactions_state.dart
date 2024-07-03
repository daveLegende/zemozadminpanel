part of 'transactions_bloc.dart';

sealed class TransactionsState extends Equatable {
  const TransactionsState();
  
  @override
  List<Object> get props => [];
}

final class TransactionsInitial extends TransactionsState {}

final class DepotLoadingState extends TransactionsState {}

final class DepotSuccessState extends TransactionsState {
  final String message;
  const DepotSuccessState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class DepotErrorState extends TransactionsState {
   final String error;
  const DepotErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

final class RetraitLoadingState extends TransactionsState {}

final class RetraitSuccessState extends TransactionsState {
  final String message;
  const RetraitSuccessState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class RetraitErrorState extends TransactionsState {
  final String error;
  const RetraitErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

