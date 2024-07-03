// import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/models/transaction.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'transac_event.dart';
part 'transac_state.dart';

class TransacBloc extends Bloc<TransacEvent, TransacState> {
  TransacBloc() : super(TransacInitial()) {
    on<TransacEvent>((event, emit) {});
    on<GetAllTransacSuccessEvent>((event, emit) async {
      await getAllTransac(event, emit);
    });
  }

  Future<void> getAllTransac(
      GetAllTransacSuccessEvent event, Emitter<TransacState> emit) async {
    final token = await PreferenceServices().getToken();
    try {
      emit(GetAllTransacLoadingState());
      final response = await http.get(
        Uri.parse(APIURL.getAlltransacURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token!,
        },
      );

      if (response.statusCode == 200) {
        print("la response: ${response.body}");
        final transacs = transacListFromJson(response.body);
        emit(GetAllTransacSuccessState(transacs: transacs));
      } else if (response.statusCode == 404) {
        print("numero de l'utilisateur non trouvé");
        emit(GetAllTransacErrorState());
      } else {
        print("erreur du serveur status code : ${response.statusCode}");
        emit(GetAllTransacErrorState());
      }
    } catch (e) {
      print(e);
      emit(GetAllTransacErrorState());
    }
  }
}
