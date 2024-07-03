import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {
    on<TransactionsEvent>((event, emit) {});
    on<DepotSuccessEvent>((event, emit) async {
      await depots(event, emit);
    });
    on<RetraitSuccessEvent>((event, emit) async {
      await retraits(event, emit);
    });
  }

  depots(DepotSuccessEvent event, Emitter<TransactionsState> emit) async {
    final token = await PreferenceServices().getToken();
    try {
      emit(DepotLoadingState());
      final response = await http.post(
        Uri.parse(APIURL.depot),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token!,
        },
        body: jsonEncode({
          "amount": event.amount,
          "phone": event.phone,
          "password": event.password,
        }),
      );

      if (response.statusCode == 200) {
        // final List<dynamic> jsonData = jsonDecode(response.body);
        // final teams = jsonData.map((e) => EquipeModel.fromJson(e)).toList();
        // print(response.body);
        emit(DepotSuccessState(
            message:
                "Depôts de ${event.amount} effectuer sur le ${event.phone}"));
      } else if (response.statusCode == 404) {
        print("numero de l'utilisateur non trouvé");
        emit(DepotErrorState(error: "${event.phone} non trouvé"));
      } else {
        print("erreur du serveur status code : ${response.statusCode}");
        emit(DepotErrorState(error: "Impossible de faire cette transaction"));
      }
    } catch (e) {
      print(e);
      emit(DepotErrorState(error: "Erreur du serveur veuillez réessayer"));
    }
  }

  retraits(RetraitSuccessEvent event, Emitter<TransactionsState> emit) async {
    final token = await PreferenceServices().getToken();
    try {
      emit(DepotLoadingState());
      final response = await http.post(
        Uri.parse(APIURL.retrait),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token!,
        },
        body: jsonEncode({
          "amount": event.amount,
          "phone": event.phone,
          "password": event.password,
        }),
      );

      if (response.statusCode == 200) {
        // final List<dynamic> jsonData = jsonDecode(response.body);
        // final teams = jsonData.map((e) => EquipeModel.fromJson(e)).toList();
        // print(response.body);
        emit(RetraitSuccessState(
            message:
                "Retrait de ${event.amount} effectuer sur le ${event.phone}"));
      } else if (response.statusCode == 404) {
        print("numero de l'utilisateur non trouvé");
        emit(RetraitErrorState(error: "${event.phone} non trouvé"));
      } else {
        print("erreur du serveur status code : ${response.statusCode}");
        emit(RetraitErrorState(error: "Impossible de faire cette transaction"));
      }
    } catch (e) {
      print(e);
      emit(RetraitErrorState(error: "Erreur du serveur veuillez réessayer"));
    }
  }
}
