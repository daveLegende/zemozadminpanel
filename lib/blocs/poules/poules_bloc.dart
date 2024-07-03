import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/models/poules.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'poules_event.dart';
part 'poules_state.dart';

class PoulesBloc extends Bloc<PoulesEvent, PoulesState> {
  PoulesBloc() : super(PoulesInitial()) {
    on<PoulesEvent>((event, emit) {});
    on<GetPouleLoadingEvent>((event, emit) {
      emit(GetPouleLoadingState());
    });
    on<GetPouleErrorEvent>((event, emit) {
      emit(GetPouleErrorState());
    });
    on<GetPouleSuccessEvent>((event, emit) async {
      await getPoules(event, emit);
    });
    on<AddPouleSuccessEvent>((event, emit) async {
      await addPoule(event, emit);
    });
  }

  getPoules(GetPouleSuccessEvent event, Emitter<PoulesState> emit) async {
    try {
      emit(GetPouleLoadingState());
      final response = await http.get(Uri.parse(APIURL.getPouleURL));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // List<dynamic> data = json.decode(response.body);
        print(response.body);
        final poules = pouleListFromJson(response.body);
        // print(poules.length);
        print("Poules récupérés");
        emit(GetPouleSuccessState(poules: poules));
      } else if (response.statusCode == 404) {
        print("Poules non trouvé");
        emit(GetPouleErrorState());
      } else {
        print("Poules non trouvé ${response.statusCode}");
        emit(GetPouleErrorState());
      }
    } catch (e) {
      print("Erreur du serveur $e");
      emit(GetPouleErrorState());
    }
  }

  // ajouter poules
  Future<void> addPoule(
      AddPouleSuccessEvent event, Emitter<PoulesState> emit) async {
    try {
      emit(AddPouleLoadingState());
      final token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.addPouleUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'nom': event.nom,
          'equipes': event.equipes,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddPouleSuccessState(message: "${event.nom} ajoutée avec succès"));
        print("Success to add ${event.nom}");
      } else if (response.statusCode == 404) {
        print('${event.nom} existe déja');
        emit(AddPouleErrorState(error: "${event.nom} existe déja"));
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        print("Erreur du serveur, status code : ${response.statusCode}");
        print("Erreur du serveur, status code : ${response.body}");
        emit(
          AddPouleErrorState(
            error: "Une erreur est survenue, certaine(s) équipes sont déja dans une poule",
          ),
        );
      }
    } catch (e) {
      print(e);
      emit(AddPouleErrorState(error: "Erreur du serveur"));
    }
  }
}
