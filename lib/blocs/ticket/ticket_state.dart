part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class ScanTicketLoadingState extends TicketState {}

final class ScanTicketSuccessState extends TicketState {
  final TicketModel? newTicket;
  const ScanTicketSuccessState({
    this.newTicket,
  });

  @override
  List<Object> get props => [newTicket!];
}

final class ScanTicketErrorState extends TicketState {}

//
final class GetTicketLoadingState extends TicketState {}

final class GetTicketSuccessState extends TicketState {
  // final List<TicketModel> todayTickets, last7DaysTickets, lastMonthTickets, totalTickets;
  final int today, seven, month, total;
  const GetTicketSuccessState({
    // required this.todayTickets,
    // required this.last7DaysTickets,
    // required this.lastMonthTickets,
    // required this.totalTickets,
    required this.today,
    required this.seven,
    required this.total,
    required this.month,
  });

  @override
  List<Object> get props => [today, seven, month, total];
  // [todayTickets, last7DaysTickets, lastMonthTickets, totalTickets];
}

final class GetTicketErrorState extends TicketState {}
