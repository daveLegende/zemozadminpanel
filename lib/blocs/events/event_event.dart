part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

final class GetEventLoadingEvent extends EventEvent {}
final class GetEventSuccessEvent extends EventEvent {
  // final List<EventModel> event;
  // const GetEventSuccessEvent({
  //   required this.event,
  // });

  // @override
  // List<Object> get props => [event];
}
final class GetEventErrorEvent extends EventEvent {}