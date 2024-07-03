part of 'event_bloc.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class GetEventLoadingState extends EventState {}

final class GetEventSuccessState extends EventState {
  final List<EventModel> events;
  const GetEventSuccessState({
    required this.events,
  });

  @override
  List<Object> get props => [events];
}

final class GetEventErrorState extends EventState {
   final String error;
  const GetEventErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
