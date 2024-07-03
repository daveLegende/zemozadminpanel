part of 'transactions_bloc.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

final class DepotLoadingEvent extends TransactionsEvent {}

final class DepotSuccessEvent extends TransactionsEvent {
  final String amount, phone, password;
  const DepotSuccessEvent({
    required this.amount,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [amount, phone, password];
}

final class DepotErrorEvent extends TransactionsEvent {}

final class RetraitLoadingEvent extends TransactionsEvent {}

final class RetraitSuccessEvent extends TransactionsEvent {
  final String amount, phone, password;
  const RetraitSuccessEvent({
    required this.amount,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [amount, phone, password];
}

final class RetraitErrorEvent extends TransactionsEvent {}