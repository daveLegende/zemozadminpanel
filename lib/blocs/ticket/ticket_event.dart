part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

final class ScanTicketLoadingEvent extends TicketEvent {}

final class ScanTicketSuccessEvent extends TicketEvent {
  final String id;
  const ScanTicketSuccessEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

final class ScanTicketErrorEvent extends TicketEvent {}

//
final class GetTicketLoadingEvent extends TicketEvent {}

final class GetTicketSuccessEvent extends TicketEvent {}

final class GetTicketErrorEvent extends TicketEvent {}
