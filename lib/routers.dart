import 'package:admin/screens/admin/admin.dart';
import 'package:admin/screens/authentication/auth.dart';
import 'package:admin/screens/chargement.dart';
import 'package:admin/screens/equipes/equipes.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/infos/infos.dart';
import 'package:admin/screens/matchs/matchs.dart';
import 'package:admin/screens/transactions/transaction.dart';
import 'package:admin/screens/poules/poules.dart';
import 'package:admin/screens/users/users.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouter {
  Map<String, Widget Function(BuildContext)> routers = {
    '/': (context) => MatchScreen(),
    // dashNamed: (context) => DashboardScreen(),
    pouleNamed: (context) => PouleScreen(),
    matchNamed: (context) => MatchScreen(),
    equipeNamed: (context) => EquipeScreen(),
    // ticketNamed: (context) => TicketScreen(),
    InfosNamed: (context) => InfoScreen(),
    paramsNamed: (context) => Parametre(),
    userNamed: (context) => UserScreen(),
    adminNamed: (context) => AdminScreen(),
  };

  final getPages = [
    GetPage(name: '/', page: () => ChargementScreen()),
    // GetPage(name: dashNamed, page: () => MainScreen()),
    GetPage(name: pouleNamed, page: () => PouleScreen()),
    GetPage(name: matchNamed, page: () => MatchScreen()),
    GetPage(name: equipeNamed, page: () => EquipeScreen()),
    // GetPage(name: ticketNamed, page: () => TicketScreen()),
    GetPage(name: paramsNamed, page: () => Parametre()),
    GetPage(name: InfosNamed, page: () => InfoScreen()),
    GetPage(name: adminNamed, page: () => AdminScreen()),
    GetPage(name: '/login', page: () => AuthScreen()),
    // '/': (context) => DashboardScreen(),
    // '/Dash': (context) => DashboardScreen(),
    // '/Poules': (context) => PouleScreen(),
    // '/Matchs': (context) => MatchScreen(),
    // '/Equipes': (context) => EquipeScreen(),
    // '/Tickets': (context) => TicketScreen(),
    // '/Infos': (context) => InfoScreen(),
    // '/Params': (context) => Parametre(),
    // '/Users': (context) => UserScreen(),
  ];
}

final String pouleNamed = "/Poules";
final String matchNamed = "/";
final String equipeNamed = "/Equipes";
final String ticketNamed = "/Tickets";
final String InfosNamed = "/Infos";
final String paramsNamed = "/Params";
final String userNamed = "/Users";
final String adminNamed = "/admins";
// final String dashNamed = "/";



// 
class MyFlurouter {

  static final FluroRouter router = FluroRouter();

  static Handler authHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) => AuthScreen(),
  );

  static Handler homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) => HomeScreen(),
  );

  static void setupRouter() {
    router.define("/", handler: authHandler);
    router.define("/dashboard/:name", handler: homeHandler);
  }
}