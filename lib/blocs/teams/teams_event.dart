part of 'teams_bloc.dart';

sealed class TeamsEvent extends Equatable {
  const TeamsEvent();

  @override
  List<Object> get props => [];
}

final class TeamsInitialEvent extends TeamsEvent {}

final class GetTeamLoadingEvent extends TeamsEvent {}

final class GetTeamSuccessEvent extends TeamsEvent {}

final class GetTeamErrorEvent extends TeamsEvent {}

final class AddTeamLoadingEvent extends TeamsEvent {}

final class AddTeamSuccessEvent extends TeamsEvent {
  final EquipeModel equipe;
  final Uint8List image;
  const AddTeamSuccessEvent({
    required this.equipe,
    required this.image,
  });

  @override
  List<Object> get props => [equipe, image];
}

final class AddTeamErrorEvent extends TeamsEvent {}
