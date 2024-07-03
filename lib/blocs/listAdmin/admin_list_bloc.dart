import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/models/admin.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'admin_list_event.dart';
part 'admin_liste_state.dart';

class AdminListBloc extends Bloc<AdminListEvent, AdminListState> {
  AdminListBloc() : super(AdminListInitial()) {
    on<AdminListEvent>((event, emit) {});
    on<GetListAdminSuccessEvent>((event, emit) async {
      await getListAdmin(event, emit);
    });
  }

  Future<void> getListAdmin(
      GetListAdminSuccessEvent event, Emitter<AdminListState> emit) async {
    emit(GetListAdminLoadingState());

    final token = await PreferenceServices().getToken();
    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse(APIURL.adminListURL),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "Bearer " + token,
          },
        );

        if (response.statusCode == 200) {
          // print(response.body);
          // Map<String, dynamic> jsonData = json.decode(response.body);
          // final data = jsonData['admin'];
          // print("--------------------------$data-------------------");
          final admins = adminListFromJson(response.body);
          emit(GetListAdminSuccessState(admins: admins));
        } else if (response.statusCode == 404) {
          print("Error du status code ${response.statusCode}");
          emit(GetListAdminErrorState());
        }
      } catch (e) {
        print("Error du catch $e");
        emit(GetListAdminErrorState());
      }
    } else {
      print("Token n'existe pas");
    }
  }
}
