import 'dart:io';

import 'package:admin/blocs/auth/auth_bloc.dart';
import 'package:admin/blocs/auth/auth_event.dart';
import 'package:admin/blocs/events/event_bloc.dart';
import 'package:admin/blocs/listAdmin/admin_list_bloc.dart';
import 'package:admin/blocs/transac/transac_bloc.dart';
import 'package:admin/blocs/user/user_bloc.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/navigate_controller.dart';
import 'package:admin/screens/chargement.dart';
import 'package:admin/services/preferences.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/services/repositeries/socket_repo.dart';
import 'package:admin/utile_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'blocs/admin/admin_bloc.dart';
import 'blocs/matchs/match_bloc.dart';
import 'blocs/poules/poules_bloc.dart';
import 'blocs/teams/teams_bloc.dart';
import 'blocs/ticket/ticket_bloc.dart';
import 'blocs/transactions/transactions_bloc.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await initializeDateFormatting('fr_FR', null);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PreferenceServices pref = PreferenceServices();
    Get.put(MyController());
    Get.put(NavigationController());
    Get.put(ApiRepositeries());
    Get.put(RepoSocket());
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(pref)..add(IsAuthenticateEvent());
          },
        ),
        BlocProvider<AdminBloc>(
          create: (context) => AdminBloc()..add(GetAdminSuccessEvent()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<TeamsBloc>(
          create: (context) => TeamsBloc(),
        ),
        BlocProvider<MatchBloc>(
          create: (context) => MatchBloc(),
        ),
        BlocProvider<PoulesBloc>(
          create: (context) => PoulesBloc(),
        ),
        BlocProvider<TransactionsBloc>(
          create: (context) => TransactionsBloc(),
        ),
        BlocProvider<TransacBloc>(
          create: (context) => TransacBloc(),
        ),
        BlocProvider<TicketBloc>(
          create: (context) => TicketBloc(),
        ),
        BlocProvider<AdminListBloc>(
          create: (context) => AdminListBloc(),
        ),
        BlocProvider<EventBloc>(
          create: (context) => EventBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Zemoz Admin',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mwhite,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            canvasColor: secondaryColor,
          ),
          initialRoute: "/",
          // getPages: AppRouter().getPages,
          // routes: AppRouter().routers,
          home: ChargementScreen(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
// +18777804236  