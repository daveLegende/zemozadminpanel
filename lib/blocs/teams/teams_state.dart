part of 'teams_bloc.dart';

sealed class TeamsState extends Equatable {
  const TeamsState();

  @override
  List<Object> get props => [];
}

final class TeamsInitial extends TeamsState {}

final class GetTeamLoadingState extends TeamsState {}

final class GetTeamSuccessState extends TeamsState {
  final List<EquipeModel> teams;
  const GetTeamSuccessState({required this.teams});

  @override
  List<Object> get props => [teams];
}

final class GetTeamErrorState extends TeamsState {
  // final String error;
  // const GetTeamErrorState(this.error);

  // @override
  // List<Object> get props => [error];
}

final class AddTeamLoadingState extends TeamsState {}

final class AddTeamSuccessState extends TeamsState {
  final String message;
  const AddTeamSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

final class AddTeamErrorState extends TeamsState {
  final String error;
  const AddTeamErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
