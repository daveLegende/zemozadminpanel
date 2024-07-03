import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/models/admin.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminEvent>((event, emit) {});
    on<GetAdminSuccessEvent>((event, emit) async {
      await getCurrentAdmin(event, emit);
    });
    on<GetAdminErrorEvent>((event, emit) {
      emit(GetAdminErrorState());
    });
    on<GetAdminLoadingEvent>((event, emit) {
      emit(GetAdminLoadingState());
    });
  }

  getCurrentAdmin(GetAdminSuccessEvent event, Emitter<AdminState> emit) async {
    emit(GetAdminLoadingState());

    final token = await PreferenceServices().getToken();
    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse(APIURL.profile),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "Bearer " + token,
          },
        );

        if (response.statusCode == 200) {
          print(response.body);
          Map<String, dynamic> jsonData = json.decode(response.body);
          final data = jsonData['admin'];
          print("--------------------------$data-------------------");
          final admin = Admin(
            id: data["_id"],
            email: data["email"],
            password: data["password"],
          );
          emit(GetAdminSuccessState(admin: admin));
        } else if (response.statusCode == 404) {
          print("Error du status code ${response.statusCode}");
          emit(GetAdminLoadingState());
        }
      } catch (e) {
        print("Error du catch $e");
        emit(GetAdminErrorState());
      }
    } else {
      print("Token n'existe pas");
    }
  }
}
