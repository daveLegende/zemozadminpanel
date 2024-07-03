import 'package:admin/blocs/auth/auth_bloc.dart';
import 'package:admin/blocs/auth/auth_state.dart';
import 'package:admin/screens/authentication/auth.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is IsAuthenticateState) {
          print("Utilisateur authentifié: page d'accueil");
          return MainScreen();
        } else if (state is UnAuthenticateStatate) {
          print("Utilisateur non authentifié");
          return AuthScreen();
        } else if (state is LoginLoadingState || state is RegisterLoadingState) {
          print("Utilisateur non authentifié");
          return AuthScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
