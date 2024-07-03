// blocs/authentication_bloc.dart
import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/services/preferences.dart';
import 'package:bloc/bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import 'package:http/http.dart' as http;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final PreferenceServices preferenceServices;
  AuthenticationBloc(this.preferenceServices) : super(InitialState()) {
    on<LoginSuccessEvent>((event, emit) async {
      await login(emit, event);
    });
    on<RegisterSuccessEvent>((event, emit) async {
      await register(emit, event);
    });
    on<IsAuthenticateEvent>((event, emit) async {
      await isAuthenticated(emit, event);
    });
    on<UnAuthenticateEvent>((event, emit) async {
      await logout(emit, event);
    });
  }

  login(Emitter<AuthenticationState> emit, LoginSuccessEvent event) async {
    try {
      emit(LoginLoadingState());
      final response = await http.post(
        Uri.parse("${APIURL.loginUrl}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(event.admin.toJson()),
      );

      if (response.statusCode == 200) {
        // Si la connexion réussit, vous pourriez également traiter la réponse JSON ici
        final Map<String, dynamic> data = json.decode(response.body);
        // Si votre API renvoie un token, vous pouvez l'utiliser ici
        final String token = data['token'];

        emit(LoginSuccessState());
        emit(IsAuthenticateState(token: token));
        await PreferenceServices().setToken(token);
      } else if (response.statusCode == 401) {
        // Utilisateur non trouvé ou mot de passe incorrect
        print('email ou mot de passe incorrecte');
        emit(LoginErrorState(message: "email ou mot de passe incorrecte"));
        emit(ErrorState(errorMessage: "email ou mot de passe incorrecte"));
      } else if (response.statusCode == 500) {
        // Erreur côté serveur lors de la génération du token
        print('Une erreur de serveur : veuillez vérifier votre connexion');
        emit(LoginErrorState(
            message:
                "Une erreur de serveur : veuillez vérifier votre connexion"));
        emit(ErrorState(
            errorMessage:
                "Une erreur de serveur : veuillez vérifier votre connexion"));
      } else {
        print('Une Erreur est survenue');
        emit(LoginErrorState(
            message: "Utilisateur non trouvé,veuillez créer un compte"));
        emit(ErrorState(
            errorMessage: "Utilisateur non trouvé,veuillez créer un compte"));
      }
    } catch (e) {
      print('Erreur lors de la connexion $e');
      emit(LoginErrorState(
          message: "Erreur lors de la connexion : Vérifier votre connexion"));
      emit(ErrorState(
          errorMessage:
              "Erreur lors de la connexion : Vérifier votre connexion"));
    }
  }

  // register
  register(
      Emitter<AuthenticationState> emit, RegisterSuccessEvent event) async {
    try {
      emit(RegisterLoadingState());
      final response = await http.post(
        Uri.parse("${APIURL.registerUrl}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": event.email,
          "password": event.password,
          "confirm": event.confirm,
        }),
      );

      if (response.statusCode == 200) {
        // Si la connexion réussit, vous pourriez également traiter la réponse JSON ici
        final Map<String, dynamic> data = json.decode(response.body);
        // Si votre API renvoie un token, vous pouvez l'utiliser ici
        final String token = data['token'];
        emit(RegisterSuccessState());
        emit(IsAuthenticateState(token: token));
        await PreferenceServices().setToken(token);
      } else if (response.statusCode == 400) {
        print('Cet utilisateur existe déja');
        emit(
          RegisterErrorState(
            message: "Un utilisateur a déja ces informations",
          ),
        );
        emit(
            ErrorState(errorMessage: "Un utilisateur a déja ces informations"));
      } else if (response.statusCode == 500) {
        // Erreur côté serveur lors de la génération du token
        emit(
          RegisterErrorState(
            message: "Erreur côté serveur: veuillez réessayer",
          ),
        );
        emit(ErrorState(
            errorMessage: "Erreur côté serveur: veuillez réessayer"));
      } else {
        emit(
          RegisterErrorState(
            message:
                "Une erreur s'est survenue: veuillez vérifier votre connexion ${response.statusCode}",
          ),
        );
        emit(ErrorState(
            errorMessage:
                "Une erreur s'est survenue: veuillez vérifier votre connexion ${response.statusCode}"));
      }
    } catch (e) {
      print(e);
      emit(
        RegisterErrorState(
          message:
              "Une erreur s'est survenue: veuillez vérifier votre connexion $e",
        ),
      );
      emit(ErrorState(
          errorMessage:
              "Une erreur s'est survenue: veuillez vérifier votre connexion $e"));
    }
  }

  // Logout
  logout(Emitter<AuthenticationState> emit, UnAuthenticateEvent event) async {
    try {
      await PreferenceServices()
          .removeToken()
          .then((value) => print("Token remove: Deconnexion réussie"));
      emit(UnAuthenticateStatate());
    } catch (e) {
      emit(ErrorState(errorMessage: "Erreur lors de la déconnexion. $e"));
    }
  }

  // isAuthenticated
  isAuthenticated(
      Emitter<AuthenticationState> emit, IsAuthenticateEvent event) async {
    try {
      final String? token = await preferenceServices.getToken();

      if (token != null) {
        // Utilisateur authentifié
        emit(IsAuthenticateState(token: token));
      } else {
        emit(
          ErrorState(errorMessage: "Utilisateur ne s'est pas authentifié"),
        );
        // Utilisateur non authentifié
        emit(UnAuthenticateStatate());
      }
    } catch (e) {
      emit(
        ErrorState(errorMessage: "Erreur rencontrée"),
      );
      // Utilisateur non authentifié
      emit(UnAuthenticateStatate());
    }
  }
}
