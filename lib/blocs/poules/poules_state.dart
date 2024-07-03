part of 'poules_bloc.dart';

sealed class PoulesState extends Equatable {
  const PoulesState();

  @override
  List<Object> get props => [];
}

final class PoulesInitial extends PoulesState {}

final class GetPouleLoadingState extends PoulesState {}

final class GetPouleSuccessState extends PoulesState {
  final List<PouleModel> poules;
  const GetPouleSuccessState({
    required this.poules,
  });

  @override
  List<Object> get props => [poules];
}

final class GetPouleErrorState extends PoulesState {}

final class AddPouleLoadingState extends PoulesState {}

final class AddPouleSuccessState extends PoulesState {
  final String message;
  const AddPouleSuccessState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class AddPouleErrorState extends PoulesState {
  final String error;
  const AddPouleErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
