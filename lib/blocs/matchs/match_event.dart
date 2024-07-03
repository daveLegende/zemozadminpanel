part of 'match_bloc.dart';

sealed class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

final class GetMatchsLoadingEvent extends MatchEvent {}

final class GetMatchsSuccessEvent extends MatchEvent {}

final class GetMatchsErrorEvent extends MatchEvent {}

// create
final class CreateMatchsLoadingEvent extends MatchEvent {}

final class CreateMatchsSuccessEvent extends MatchEvent {
  final String date;
  final String homeId;
  final String awayId;
  final String type;
  final String pouleId;
  const CreateMatchsSuccessEvent({
    required this.homeId,
    required this.awayId,
    required this.type,
    required this.pouleId,
    required this.date,
  });

  @override
  List<Object> get props => [homeId, awayId, type, pouleId, date];
}

final class CreateMatchsErrorEvent extends MatchEvent {}

//

final class MatchsUpdateSocketErrorEvent extends MatchEvent {
  // final String error;
  // const MatchsUpdateSocketErrorEvent({
  //   required this.error,
  // });

  // @override
  // List<Object> get props => [error];
}

final class MatchsUpdateSocketSuccessEvent extends MatchEvent {
  final String message, matchId, homeScore, awayScore;
  final String aFautes, aCorners, aJaune, aRouge;
  final String hFautes, hCorners, hJaune, hRouge;
  final List<String> aButeurs, aPasseurs, hButeurs, hPasseurs;
  const MatchsUpdateSocketSuccessEvent({
    required this.message,
    required this.matchId,
    required this.homeScore,
    required this.awayScore,
    required this.aFautes,
    required this.aButeurs,
    required this.aJaune,
    required this.aCorners,
    required this.aPasseurs,
    required this.aRouge,
    required this.hFautes,
    required this.hButeurs,
    required this.hJaune,
    required this.hCorners,
    required this.hPasseurs,
    required this.hRouge,
  });

  @override
  List<Object> get props => [
        message,
        matchId,
        homeScore,
        awayScore,
        aButeurs,
        aPasseurs,
        aFautes,
        aCorners,
        aRouge,
        aJaune,
        hButeurs,
        hPasseurs,
        hFautes,
        hCorners,
        hRouge,
        hJaune
      ];
}

final class MatchEventUpdate extends MatchEvent {
  final String message, matchId, homeScore, awayScore;
  final String hbj, hbt, hcj, hct, hcc;
  final String abj, abt, acj, act, acc;
  const MatchEventUpdate({
    required this.message,
    required this.matchId,
    required this.homeScore,
    required this.awayScore,
    required this.hbj,
    required this.hbt,
    required this.hcj,
    required this.hct,
    required this.hcc,
    required this.abj,
    required this.abt,
    required this.acj,
    required this.act,
    required this.acc,
  });

  @override
  List<Object> get props => [
        message,
        matchId,
        homeScore,
        awayScore,
        abj,
        abt,
        acj,
        act,
        acc,
        hbj,
        hbt,
        hcj,
        hct,
        hcc
      ];
}

final class MatchsUpdateSocketLoadingEvent extends MatchEvent {}

//
final class MatchStartEndLoadingEvent extends MatchEvent {}

final class MatchStartEndSuccessEvent extends MatchEvent {
  // final String message;
  final String matchId, matchState;
  const MatchStartEndSuccessEvent({
    // required this.message,
    required this.matchId,
    required this.matchState,
  });

  @override
  List<Object> get props => [matchId, matchState];
}

final class MatchStartEndErrorEvent extends MatchEvent {}
