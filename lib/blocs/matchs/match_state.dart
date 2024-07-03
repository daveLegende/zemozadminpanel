part of 'match_bloc.dart';

sealed class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

final class MatchInitial extends MatchState {}

final class GetMatchsLoadingState extends MatchState {}

final class GetMatchsSuccessState extends MatchState {
  final List<MatchModel> matchs;
  const GetMatchsSuccessState({
    required this.matchs,
  });

  @override
  List<Object> get props => [matchs];
}

final class GetMatchsErrorState extends MatchState {
  final String error;
  const GetMatchsErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// create
final class CreateMatchsLoadingState extends MatchState {}

final class CreateMatchsSuccessState extends MatchState {
  final String message;
  const CreateMatchsSuccessState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class CreateMatchsErrorState extends MatchState {
  final String error;
  const CreateMatchsErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// socket
final class MatchsUpdateSocketErrorState extends MatchState {
  final String error;
  const MatchsUpdateSocketErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

final class MatchsUpdateSocketSuccessState extends MatchState {
  final String message;
  // final MatchModel match;
  const MatchsUpdateSocketSuccessState({
    required this.message,
    // required this.match,
  });

  @override
  List<Object> get props => [message];
}

final class MatchsUpdateSocketLoadingState extends MatchState {}


// 
final class MatchEventUpdateErrorState extends MatchState {
  final String error;
  const MatchEventUpdateErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

final class MatchEventUpdateSuccessState extends MatchState {
  final String message;
  // final MatchModel match;
  const MatchEventUpdateSuccessState({
    required this.message,
    // required this.match,
  });

  @override
  List<Object> get props => [message];
}

final class MatchEventUpdateLoadingState extends MatchState {}

// 
final class MatchStartEndLoadingState extends MatchState {}

final class MatchStartEndSuccessState extends MatchState {
  final String message;
  const MatchStartEndSuccessState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class MatchStartEndErrorState extends MatchState {
  final String error;
  const MatchStartEndErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}



