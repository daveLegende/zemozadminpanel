// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:admin/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:admin/api/url.dart';
import 'package:admin/services/preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserSuccessEvent>((event, emit) async {
      // await getCurrentUser(event, emit);
    });
    on<GetListUsersSuccessEvent>((event, emit) async {
      await getAllUsers(event, emit);
    });
    // on<GetUserLoadingEvent>((event, emit) {
    //   emit(GetUserLoadingState());
    // });

    // on<UpdateUserFlutterEvent>((event, emit) async {
    //   updateMySold(event, emit);
    // });

    // on<UpdateUserSuccessEvent>((event, emit) async {
    //   await updateCurrentUser(event, emit);
    // });
    // on<UpdateUserErrorEvent>((event, emit) {
    //   emit(UpdateUserErrorState());
    // });
    // on<UpdateUserLoadingEvent>((event, emit) {
    //   emit(UpdateUserLoadingState());
    // });
  }

  // get current user
  UserModel userFromJson(String jsonString) {
    var data = json.decode(jsonString);
    return UserModel.fromJson(data);
  }

  // getCurrentUser(GetUserSuccessEvent event, Emitter<UserState> emit) async {
  //   emit(GetUserLoadingState());

  //   final token = await PreferenceServices().getToken();
  //   if (token != null) {
  //     try {
  //       final response = await http.get(
  //         Uri.parse(APIURL.profileURL),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //           'Authorization': "Bearer $token",
  //         },
  //       );
  //       // print("object");

  //       if (response.statusCode == 200) {
  //         print(response.body);
  //         Map<String, dynamic> jsonData = json.decode(response.body);
  //         final data = jsonData['user'];
  //         print("ressui");
  //         final user = UserModel.fromJson(data);
  //         emit(GetUserSuccessState(user: user));
  //         //emit(UpdateUserSuccessState(user: user));
  //         return user;
  //       } else if (response.statusCode == 404) {
  //         print("Error du status code ${response.statusCode}");
  //         emit(GetUserLoadingState());
  //       }
  //     } catch (e) {
  //       print("Error du catch $e");
  //       emit(GetUserErrorState());
  //     }
  //   } else {
  //     print("Token n'existe pas");
  //       emit(GetUserErrorState());
  //   }
  // }

  // list off users
  getAllUsers(GetListUsersSuccessEvent event, Emitter<UserState> emit) async {
    final token = await PreferenceServices().getToken();
    try {
      emit(GetListUsersLoadingState());
      final response = await http.get(
        Uri.parse(APIURL.getAllUserURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token!,
        },
      );

      if (response.statusCode == 200) {
        // final List<dynamic> jsonData = jsonDecode(response.body);
        // final teams = jsonData.map((e) => EquipeModel.fromJson(e)).toList();
        // print(response.body);
        final users = usersListFromJson(response.body);
        emit(GetListUsersSuccessState(user: users));
      } else if (response.statusCode == 404) {
        print('users not found');
        emit(GetListUsersErrorState());
      } else {
        print("erreur du serveur status code : ${response.statusCode}");
        emit(GetListUsersErrorState());
      }
    } catch (e) {
      print(e);
      emit(GetListUsersErrorState());
    }
  }
}

updateMySold(UpdateUserFlutterEvent event, Emitter<UserState> emit) {
  if (event.groupe! == "STANDARD") {
    emit(UpdateUserFlutterState(
        user: event.user!,
        sold: double.parse(event.sold) == 0
            ? "0"
            : double.parse(event.sold) < event.standardSold
                ? event.sold
                : (double.parse(event.sold) - event.standardSold).toString()));
  } else if (event.groupe! == "VIP") {
    emit(UpdateUserFlutterState(
        user: event.user!,
        sold: double.parse(event.sold) == 0
            ? "0"
            : double.parse(event.sold) < event.vipSolde
                ? event.sold
                : (double.parse(event.sold) - event.vipSolde).toString()));
  }
}

// updateCurrentUser(event, Emitter<UserState> emit) async {
//   emit(GetUserLoadingState());

//   final token = await PreferenceServices().getToken();
//   if (token != null) {
//     try {
//       final response = await http.get(
//         Uri.parse(APIURL.getuserUpdateURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': "Bearer $token",
//         },
//       );
//       // print("updating ...");

//       if (response.statusCode == 200) {
//         // print(response.body);
//         Map<String, dynamic> jsonData = json.decode(response.body);
//         final data = jsonData['user'];
//         // print(data);
//         final user = UserModel.fromJson(data);
//         emit(UpdateUserSuccessState(user: user));
//         return user;
//       } else if (response.statusCode == 404) {
//         // print("Error du status code ${response.statusCode}");
//         emit(UpdateUserLoadingState());
//       }
//     } catch (e) {
//       // print("Error du catch $e");
//       emit(GetUserErrorState());
//     }
//   } else {
//     // print("Token n'existe pas");
//     emit(GetUserErrorState());
//   }
// }
