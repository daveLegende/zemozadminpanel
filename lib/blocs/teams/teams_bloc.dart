import 'dart:typed_data';

import 'package:admin/models/equipe.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:admin/api/url.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc() : super(TeamsInitial()) {
    on<GetTeamSuccessEvent>((event, emit) async {
      await getAllTeam(event, emit);
    });
    // on<AddTeamSuccessEvent>((event, emit) async {
    //   await addTeam(event, emit);
    // });
  }

  getAllTeam(GetTeamSuccessEvent event, Emitter<TeamsState> emit) async {
    final token = await PreferenceServices().getToken();
    try {
      emit(GetTeamLoadingState());
      final response = await http.get(
        Uri.parse(APIURL.getTeamUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token!,
        },
      );

      if (response.statusCode == 200) {
        // final List<dynamic> jsonData = jsonDecode(response.body);
        // final teams = jsonData.map((e) => EquipeModel.fromJson(e)).toList();
        // print(response.body);
        final teams = equipeListFromJson(response.body);
        emit(GetTeamSuccessState(teams: teams));
      } else if (response.statusCode == 404) {
        print('Team not found');
        emit(GetTeamErrorState());
      } else {
        print("erreur du serveur status code : ${response.statusCode}");
        emit(GetTeamErrorState());
      }
    } catch (e) {
      print(e);
      emit(GetTeamErrorState());
    }
  }

  Future<void> addTeam(
      AddTeamSuccessEvent event, Emitter<TeamsState> emit) async {
    try {
      final token = await PreferenceServices().getToken();
      emit(AddTeamLoadingState());

      var request = http.MultipartRequest('POST', Uri.parse(APIURL.addTeamUrl));

      request.fields['nom'] = event.equipe.nom;
      request.fields['coach'] = event.equipe.coach;
      request.fields['commune'] = event.equipe.commune;
      request.fields['joueurs'] = event.equipe.joueurs.toString();
      request.files.add(
        http.MultipartFile.fromBytes(
          "logo",
          event.image.cast(),
          // await File(event.equipe.logo).length(),
          filename: event.equipe.logo.split('/').last,
          contentType: MediaType('image', '*'),
        ),
      );
      // var file = await http.MultipartFile.fromPath(
      //   'logo',
      //   event.equipe.logo,
      //   // await File(event.equipe.logo).length(),
      //   filename: event.equipe.logo.split('/').last,
      //   contentType: MediaType('image',
      //       '*'), // Assurez-vous d'adapter le type de contenu correctement
      // );
      // request.files.add(file);
      request.headers.addAll({
        "Content-type": "multipart/form-data",
        'Authorization': "Bearer " + token!,
        // "Authorization": "Bearer $token",
      });

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        print('Réponse du serveur : $responseData');
        emit(AddTeamSuccessState(
            message: "${event.equipe.nom} crée avec succès"));
      } else if (response.statusCode == 404) {
        print('Equipe ${event.equipe.nom} existe déja');
        emit(AddTeamErrorState(error: "${event.equipe.nom} existe déja"));
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        print(
            "Erreur du serveur, status code : ${response.stream.bytesToString()}");
        emit(AddTeamErrorState(
            error: "Une erreur est survenue, veuilllez réssayer"));
      }
    } catch (e) {
      print(e);
      emit(AddTeamErrorState(error: "Erreur du serveur"));
    }
  }
}
