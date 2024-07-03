part of 'poules_bloc.dart';

sealed class PoulesEvent extends Equatable {
  const PoulesEvent();

  @override
  List<Object> get props => [];
}

final class GetPouleLoadingEvent extends PoulesEvent {}

final class GetPouleSuccessEvent extends PoulesEvent {}

final class GetPouleErrorEvent extends PoulesEvent {}

final class AddPouleLoadingEvent extends PoulesEvent {}

final class AddPouleSuccessEvent extends PoulesEvent {
  final String nom;
  final List<String> equipes;
  const AddPouleSuccessEvent({
    required this.nom,
    required this.equipes,
  });

  @override
  List<Object> get props => [nom, equipes];
}

final class AddPouleErrorEvent extends PoulesEvent {
  final String error;
  const AddPouleErrorEvent({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
