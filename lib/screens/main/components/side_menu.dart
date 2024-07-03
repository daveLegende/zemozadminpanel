import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/navigate_controller.dart';
import 'package:admin/routers.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            child: Center(
              child: Text(
                "ZEMOZ ADMIN PANEL",
                textAlign: TextAlign.center,
                style: StyleText().transStyle.copyWith(
                      color: mwhite,
                    ),
              ),
            ),
          ),
          Divider(
            color: mgrey,
          ),
          // DrawerHeader(
          //   child: Image.asset("assets/images/zmz.png"),
          // ),
          // DrawerListTile(
          //   title: "Dashboard",
          //   svgSrc: "assets/icons/menu_dashboard.svg",
          //   routeNamed: dashNamed,
          // ),
          // DrawerExpansionTile(
          //   title: "",
          //   routeNamed: "/Matchs",
          //   svgSrc: "",
          // ),
          DrawerListTile(
            title: "Matchs",
            svgSrc: "assets/icons/match.svg",
            routeNamed: "/",
          ),
          DrawerListTile(
            title: "Equipes",
            svgSrc: "assets/icons/equipe.svg",
            routeNamed: equipeNamed,
          ),
          DrawerListTile(
            title: "Poules",
            svgSrc: "assets/icons/poules.svg",
            routeNamed: pouleNamed,
          ),
          DrawerListTile(
            title: "Tournoi Info",
            svgSrc: "assets/icons/menu_store.svg",
            routeNamed: InfosNamed,
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_profile.svg",
            routeNamed: userNamed,
          ),
          DrawerListTile(
            title: "Transactions",
            svgSrc: "assets/icons/deposit.svg",
            routeNamed: paramsNamed,
          ),
          DrawerListTile(
            title: "Administrateurs",
            svgSrc: "assets/icons/admin.svg",
            routeNamed: adminNamed,
          ),
          DrawerListTile(
            title: "Tickets",
            svgSrc: "assets/icons/ticket.svg",
            routeNamed: ticketNamed,
          ),
        ],
      ),
    );
  }
}

// class DrawerExpansionTile extends StatelessWidget {
//   const DrawerExpansionTile({
//     super.key,
//     required this.title,
//     required this.svgSrc,
//     required this.routeNamed,
//   });

//   final String title, svgSrc, routeNamed;

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<MyController>();
//     var isSelected = controller.selectedSidebarItem == routeNamed;
//     return ExpansionTile(
//       tilePadding: EdgeInsets.only(left: 18),
//       leading: SvgPicture.asset(
//         "assets/icons/match.svg",
//         colorFilter: isSelected
//             ? ColorFilter.mode(mbSeconderedColorKbe, BlendMode.srcIn)
//             : ColorFilter.mode(Colors.white54, BlendMode.srcIn),
//         height: 16,
//       ),
//       title: Text(
//         "Matchs",
//         style: TextStyle(
//             color: isSelected ? mbSeconderedColorKbe : Colors.white54),
//       ),
//       onExpansionChanged: (expanded) {
//         if (expanded) {
//           controller.updateSelectedSidebarItem(routeNamed);
//         }
//       },
//       children: [
//         DrawerSubListTile(
//           title: "En cours",
//           routeNamed: "/en_cours",
//           press: () {},
//         ),
//         DrawerSubListTile(
//           title: "Terminés",
//           routeNamed: "/termines",
//           press: () {},
//         ),
//         DrawerSubListTile(
//           title: "À venir",
//           routeNamed: "/a_venir",
//           press: () {},
//         ),
//       ],
//     );
//   }
// }

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.routeNamed,
  }) : super(key: key);

  final String title, svgSrc, routeNamed;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MyController>();

    return Obx(() {
      final isSelected = controller.selectedSidebarItem.value == routeNamed;

      return ListTile(
        onTap: () {
          controller.updateSelectedSidebarItem(routeNamed);
          Get.toNamed(routeNamed);
        },
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          colorFilter: isSelected
              ? ColorFilter.mode(mbSeconderedColorKbe, BlendMode.srcIn)
              : ColorFilter.mode(mwhite, BlendMode.srcIn),
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? mbSeconderedColorKbe : mwhite,
          ),
        ),
      );
    });
  }
}

class DrawerSubListTile extends StatelessWidget {
  const DrawerSubListTile({
    Key? key,
    required this.title,
    required this.routeNamed,
    required this.press,
  }) : super(key: key);

  final String title, routeNamed;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: mred,
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
      leading: Icon(
        Icons.food_bank_outlined,
        color: mtransparent,
      ),
    );
  }
}
