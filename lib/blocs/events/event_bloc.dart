// ignore_for_file: depend_on_referenced_packages

import 'package:admin/models/event.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:admin/api/url.dart';
import 'package:http/http.dart' as http;

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<GetEventSuccessEvent>((event, emit) async {
      await getEvents(event, emit);
    });
  }

  getEvents(GetEventSuccessEvent event, Emitter<EventState> emit) async {
    try {
      // final token = await PreferenceServices().getToken();
      emit(GetEventLoadingState());
      final response = await http.get(
        Uri.parse(APIURL.getEventURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Authorization': "Bearer " + token!,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // List<dynamic> data = json.decode(response.body);
        // print(response.body);

        // Convertir le JSON en liste de Match
        // final matchs = jsonData.map((match) => MatchModel.fromJson(match)).toList();
        List<EventModel> events = eventListFromJson(response.body);
        print(events.length);
        // print("events récupérés");
        emit(GetEventSuccessState(events: events));
      } else if (response.statusCode == 404) {
        print("Event non trouvé --------");
        print("--------${response.body}");
        emit(const GetEventErrorState(error: "evènements non trouvé"));
      } else {
        print("Event non trouvé ${response.statusCode}");
        emit(const GetEventErrorState(
            error: "Une erreur est survenue: Veuillez réessayer"));
      }
    } catch (e) {
      print("Erreur du serveur $e");
      emit(const GetEventErrorState(error: "Erreur du serveur"));
    }
  }
}
