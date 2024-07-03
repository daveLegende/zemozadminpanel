import 'dart:async';
import 'dart:convert';

import 'package:admin/models/match_model.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:admin/api/url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(APIURL.socketURL));

  final matchUpdatesController = StreamController<MatchModel>();
  MatchBloc() : super(MatchInitial()) {
    on<MatchEvent>((event, emit) async {
      return;
    });
    // on<GetMatchsErrorEvent>((event, emit) async {
    //   emit(GetMatchsErrorState(error: eve));
    // });
    on<CreateMatchsSuccessEvent>((event, emit) async {
      await createMatch(event, emit);
    });
    on<GetMatchsSuccessEvent>((event, emit) async {
      await getMatchs(event, emit);
    });
    on<MatchsUpdateSocketSuccessEvent>((event, emit) async {
      await updateMatch(event, emit);
    });
    on<MatchEventUpdate>((event, emit) async {
      await matchEventUpdate(event, emit);
    });
  }

  // recupérer les matchs
  getMatchs(GetMatchsSuccessEvent event, Emitter<MatchState> emit) async {
    try {
      emit(GetMatchsLoadingState());
      final response = await http.get(
        Uri.parse(APIURL.getMatchURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // List<dynamic> data = json.decode(response.body);
        print(response.body);

        // Convertir le JSON en liste de Match
        // final matchs = jsonData.map((match) => MatchModel.fromJson(match)).toList();
        List<MatchModel> matchs = matchListFromJson(response.body);
        print(matchs.length);
        print("Matchs récupérés");
        emit(GetMatchsSuccessState(matchs: matchs));
      } else if (response.statusCode == 404) {
        print("Match non trouvé");
        emit(GetMatchsErrorState(error: "Match non trouvé"));
      } else {
        print("Match non trouvé ${response.statusCode}");
        emit(GetMatchsErrorState(
            error: "Une erreur est survenue: Veuillez réessayer"));
      }
    } catch (e) {
      print("Erreur du serveur $e");
      emit(GetMatchsErrorState(error: "Erreur du serveur"));
    }
  }

  // create
  createMatch(CreateMatchsSuccessEvent event, Emitter<MatchState> emit) async {
    try {
      emit(CreateMatchsLoadingState());
      String? token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.createMatchURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "homeId": event.homeId,
          "awayId": event.awayId,
          "type": event.type,
          "pouleId": event.pouleId,
          "date": event.date,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateMatchsSuccessState(
            message: "Confrontation céée avec succès"));
        print("Success to add match");
      } else if (response.statusCode == 404) {
        print('Match existe déja');
        emit(CreateMatchsErrorState(error: "Cette confrontation existe déja"));
      } else if (response.statusCode == 403) {
        print(response.body);
        emit(CreateMatchsErrorState(error: response.body));
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        emit(
          CreateMatchsErrorState(
            error: "Une erreur est survenue, veuilllez réssayer",
          ),
        );
      }
    } catch (e) {
      print(e);
      emit(CreateMatchsErrorState(error: "Erreur du serveur"));
    }
  }

  updateMatch(
      MatchsUpdateSocketSuccessEvent event, Emitter<MatchState> emit) async {
    emit(MatchsUpdateSocketLoadingState());
    try {
      final message = {
        'type': 'updateMatch',
        "matchId": event.matchId,
        'homeScore': event.homeScore,
        'awayScore': event.awayScore,
        "hButeurs": event.hButeurs,
        "hPasseurs": event.hPasseurs,
        "hFautes": event.hFautes,
        "hCorners": event.hCorners,
        "hJaune": event.hJaune,
        "hRouge": event.hRouge,
        "aButeurs": event.aButeurs,
        "aPasseurs": event.aPasseurs,
        "aFautes": event.aFautes,
        "aCorners": event.aCorners,
        "aJaune": event.aJaune,
        "aRouge": event.aRouge,
      };
      channel.sink.add(jsonEncode(message));
      emit(MatchsUpdateSocketSuccessState(message: "Match mis à jour"));
    } catch (e) {
      print('Erreur du serveur $e');
      emit(MatchsUpdateSocketErrorState(error: 'Erreur du serveur'));
    }
  }

  // new
  Future<void> matchEventUpdate(
      MatchEventUpdate event, Emitter<MatchState> emit) async {
    emit(MatchsUpdateSocketLoadingState());
    try {
      final message = {
        'type': 'matchEvent',
        "matchId": event.matchId,
        'homeScore': event.homeScore,
        'awayScore': event.awayScore,
        "hbj": event.hbj,
        "hbt": event.hbt,
        "hcj": event.hcj,
        "hct": event.hct,
        "hcc": event.hcc,
        "abj": event.abj,
        "abt": event.abt,
        "acj": event.acj,
        "act": event.act,
        "acc": event.acc,
      };
      channel.sink.add(jsonEncode(message));
      emit(MatchEventUpdateSuccessState(message: "Match mis à jour"));
    } catch (e) {
      print('Erreur du serveur $e');
      emit(MatchEventUpdateErrorState(error: 'Erreur du serveur'));
    }
  }

  // commencer ou terminer un match
  startOrEndMatch(
      MatchStartEndSuccessEvent event, Emitter<MatchState> emit) async {
    emit(MatchStartEndLoadingState());
    try {
      final message = {
        'type': 'matchState',
        "matchId": event.matchId,
        "matchState": event.matchState,
      };
      channel.sink.add(jsonEncode(message));
      emit(MatchStartEndSuccessState(message: "Modification apportée"));
    } catch (e) {
      print('Erreur du serveur $e');
      emit(MatchsUpdateSocketErrorState(error: 'Erreur du serveur'));
    }
  }
}
