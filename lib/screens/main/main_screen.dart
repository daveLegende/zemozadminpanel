// ignore_for_file: dead_code

import 'package:admin/constant.dart';
// import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/navigate_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/admin/admin.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/equipes/equipes.dart';
import 'package:admin/screens/infos/infos.dart';
import 'package:admin/screens/matchs/matchs.dart';
import 'package:admin/screens/transactions/transaction.dart';
import 'package:admin/screens/poules/poules.dart';
import 'package:admin/screens/tickets/tickets.dart';
import 'package:admin/screens/users/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mwhite,
      // key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Column(
                children: [
                  Header(),
                  Expanded(
                    child: Obx(
                      () {
                        var currentRoute =
                            Get.find<MyController>().selectedSidebarItem.value;
                        Widget content = SizedBox(
                          child: Center(
                            child: Text(
                              "guiseigfbueguydsu",
                              style: TextStyle(color: mwhite),
                            ),
                          ),
                        );
    
                        switch (currentRoute) {
                          case "/":
                            return MatchScreen();
                            break;
                          case "/Equipes":
                            return EquipeScreen();
                            break;
                          case "/Poules":
                            return PouleScreen();
                            break;
                          case "/Tickets":
                            content = TicketScreen(isShowingMainData: true,);
                            break;
                          case "/Infos":
                            content = InfoScreen();
                            break;
                          case "/Matchs":
                            content = MatchScreen();
                            break;
                          case "/Params":
                            content = Parametre();
                            break;
                          case "/Users":
                            content = UserScreen();
                            break;
                          case "/admins":
                            content = AdminScreen();
                            break;
                          default:
                            content = SizedBox(
                              child: Text("sghlis"),
                            );
                        }
                        return content;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
