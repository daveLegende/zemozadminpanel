import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/models/ticket.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(APIURL.socketURL));
  TicketBloc() : super(TicketInitial()) {
    on<ScanTicketSuccessEvent>((event, emit) async {
      await scanTickets(event, emit);
    });
    on<GetTicketSuccessEvent>((event, emit) async {
      await getAllTickets(event, emit);
    });
  }

  scanTicket(ScanTicketSuccessEvent event, Emitter<TicketState> emit) async {
    try {
      String? token = await PreferenceServices().getToken();
      emit(ScanTicketLoadingState());
      final response = await http.post(
        Uri.parse(APIURL.scanTicketURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "id": event.id,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> jsonData = json.decode(response.body);
        final data = jsonData['ticket'];
        print("--------------------------$data-------------------");
        final ticket = TicketModel.fromJson(data);
        emit(ScanTicketSuccessState(newTicket: ticket));
      } else if (response.statusCode == 404) {
        print("Veuilllez verifer votre connexion");
        emit(ScanTicketErrorState());
      }
    } catch (e) {
      print("Erreur du serveur $e");
      emit(ScanTicketErrorState());
    }
  }

  // scan avec socket
  scanTickets(ScanTicketSuccessEvent event, Emitter<TicketState> emit) async {
    emit(ScanTicketLoadingState());
    try {
      final message = {
        'type': 'scan',
        "id": event.id,
      };
      channel.sink.add(jsonEncode(message));
      emit(ScanTicketSuccessState());
    } catch (e) {
      print('Erreur du serveur $e');
      emit(ScanTicketErrorState());
    }
  }

  Future<void> getAllTickets(
      GetTicketSuccessEvent event, Emitter<TicketState> emit) async {
    final token = await PreferenceServices().getToken();
    try {
      emit(GetTicketLoadingState());
      final response = await http.get(
        Uri.parse(APIURL.getTicketsURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token!,
        },
      );

      if (response.statusCode == 200) {
        print('--------------------${response.body}');
        Map<String, dynamic> jsonData = json.decode(response.body);

        int todayTickets = jsonData['today'].length;
        int last7DaysTickets = jsonData['sevenDays'].length;
        int lastMonthTickets = jsonData['month'].length;
        int totalTickets = jsonData['total'].length;

        emit(
          GetTicketSuccessState(
            today: todayTickets,
            seven: last7DaysTickets,
            month: lastMonthTickets,
            total: totalTickets,
          ),
        );
      } else if (response.statusCode == 404) {
        print('Tickets not found');
        emit(GetTicketErrorState());
      } else {
        print("erreur du serveur status code : ${response.statusCode}");
        emit(GetTicketErrorState());
      }
    } catch (e) {
      print(e);
      emit(GetTicketErrorState());
    }
  }
}
