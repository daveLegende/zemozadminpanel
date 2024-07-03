// import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:admin/style.dart';
import 'package:toastification/toastification.dart';

import 'constant.dart';
import 'models/match_model.dart';

class Helper {
  customAppBar(String title) {
    return AppBar(
      backgroundColor: mwhite,
      iconTheme: const IconThemeData(
        color: mblack,
      ),
      // centerTitle: true,
      title: Text(
        title,
        style: StyleText().transStyle,
      ),
    );
  }

  // List<List<MatchModel>> groupMatchesByDate(List<MatchModel> matches) {
  //   Map<String, List<MatchModel>> groupedMatches = {};

  //   for (var match in matches) {
  //     // Ajouter une condition pour ne conserver que les matchs avec l'état "A_VENIR"
  //     if (match.etat == "A_VENIR") {
  //       // Convertir la date au format ISO 8601 en objet DateTime
  //       DateTime matchDate = DateTime.parse(match.date.toString());

  //       // Formater la date pour l'utiliser comme clé dans la map
  //       String dateKey =
  //           '${matchDate.year}-${matchDate.month}-${matchDate.day}';

  //       if (groupedMatches.containsKey(dateKey)) {
  //         groupedMatches[dateKey]!.add(match);
  //       } else {
  //         groupedMatches[dateKey] = [match];
  //       }
  //     }
  //   }

  //   // Convertir la map en liste pour l'affichage
  //   List<List<MatchModel>> result = groupedMatches.values.toList();
  //   return result;
  // }

  void goTo({required BuildContext context, required Widget page}) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  // remove until
  void goToAndRemoveUntil(
      {required BuildContext context, required Widget page}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
      (route) => false,
    );
  }

  // svg icon
  Widget svgIcon(String svg, double size) {
    return SvgPicture.asset(
      svg,
      width: size,
      height: size,
    );
  }

  // format
  String formatMontant(double montant) {
    var somme =
        NumberFormat.currency(locale: 'fr-fr', decimalDigits: 0, name: 'cfa')
            .format(montant)
            .toString();
    return somme.trim();
  }

  // score
  String getScore({required int home, required int away}) {
    return "$home : $away";
  }

  String formatNumber(int number) {
    if (number >= 1000) {
      final double abbreviated = number / 1000.0;
      const String suffix = 'k';
      return '${abbreviated.toStringAsFixed(1)}$suffix';
    }
    return number.toString();
  }

  String afficherHeureMinute(DateTime dateTime) {
    String heureMinute = DateFormat.Hm().format(dateTime);
    return heureMinute;
  }

  String formatDate(DateTime dateTime) {
    final dt = DateFormat('dd.MM.yy HH:mm').format(dateTime);
    return dt;
  }

  String formatDate2(DateTime dateTime) {
    final dt = DateFormat('dd/MM/yy').format(dateTime);
    return dt;
  }

  String dateEcole(DateTime dateTime) {
    String formattedDate =
        DateFormat('EEEE dd MMMM yyyy', 'fr_FR').format(dateTime);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  String birthDate(DateTime dateTime) {
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(dateTime);
    return formattedDate;
  }

  // // has pass
  // Future<String> hashPassword(String password) async {
  //   final hashedPassword =
  //       await BCrypt.hashpw(password, BCrypt.gensalt(logRounds: 10));

  //   return hashedPassword;
  // }

  // snackbar
  void mySuccessToast(String message, BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text('Message', style: TextStyle(color: mblack, fontWeight: FontWeight.bold),),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: TextSpan(text: message,style: StyleText().googleTitre)),
      alignment: Alignment.topRight,
      // direction: TextDirection.LTR,
      animationDuration: const Duration(milliseconds: 300),
      // animationBuilder: (context, animation, alignment, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   );
      // },
      icon: const Icon(Icons.check),
      primaryColor: mbSeconderedColorKbe,
      backgroundColor: mwhite,
      // foregroundColor: mwhite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      // boxShadow: const [
      //   BoxShadow(
      //     color: mgrey,
      //     blurRadius: 16,
      //     offset: Offset(0, 16),
      //     spreadRadius: 0,
      //   )
      // ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      // applyBlurEffect: true,
      // callbacks: ToastificationCallbacks(
      //   onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
      //   onCloseButtonTap: (toastItem) =>
      //       print('Toast ${toastItem.id} close button tapped'),
      //   onAutoCompleteCompleted: (toastItem) =>
      //       print('Toast ${toastItem.id} auto complete completed'),
      //   onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      // ),
    );
  }

  void myErrorToast(String message, BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text('Erreur', style: TextStyle(color: mblack, fontWeight: FontWeight.bold),),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: TextSpan(text: message,style: StyleText().googleTitre)),
      alignment: Alignment.topRight,
      // direction: TextDirection.LTR,
      animationDuration: const Duration(milliseconds: 300),
      // animationBuilder: (context, animation, alignment, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   );
      // },
      icon: const Icon(Icons.cancel),
      primaryColor: mred,
      backgroundColor: mwhite,
      // foregroundColor: mwhite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      // boxShadow: const [
      //   BoxShadow(
      //     color: mgrey,
      //     blurRadius: 16,
      //     offset: Offset(0, 16),
      //     spreadRadius: 0,
      //   )
      // ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      // applyBlurEffect: true,
      // callbacks: ToastificationCallbacks(
      //   onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
      //   onCloseButtonTap: (toastItem) =>
      //       print('Toast ${toastItem.id} close button tapped'),
      //   onAutoCompleteCompleted: (toastItem) =>
      //       print('Toast ${toastItem.id} auto complete completed'),
      //   onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      // ),
    );
  }

  void showToast(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: StyleText().greyFont.copyWith(color: mwhite),
        ),
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: mbSeconderedColorKbe,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  }

  //
  List<List<MatchModel>> groupMatchesByDate(List<MatchModel> matches) {
    Map<String, List<MatchModel>> groupedMatches = {};

    for (var match in matches) {
      // Ajouter une condition pour ne conserver que les matchs avec l'état "A_VENIR"
      if (match.etat == "A_VENIR") {
        // Convertir la date au format ISO 8601 en objet DateTime
        DateTime matchDate = DateTime.parse(match.date.toString());

        // Formater la date pour l'utiliser comme clé dans la map
        String dateKey =
            '${matchDate.year}-${matchDate.month}-${matchDate.day}';

        if (groupedMatches.containsKey(dateKey)) {
          groupedMatches[dateKey]!.add(match);
        } else {
          groupedMatches[dateKey] = [match];
        }
      }
    }

    // Convertir la map en liste pour l'affichage
    List<List<MatchModel>> result = groupedMatches.values.toList();
    return result;
  }

  // Future<void> showLogoutDialog(
  //     {required BuildContext context, required void Function() onTap}) async {
  //   showCupertinoDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) {
  //       return Center(
  //         child: Container(
  //           width: width,
  //           height: width / 2.5,
  //           margin: const EdgeInsets.symmetric(horizontal: 40),
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //           decoration: BoxDecoration(
  //             color: mwhite,
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               RichText(
  //                 text: TextSpan(
  //                   text: "Déconnexion",
  //                   style: StyleText().primaryFont,
  //                 ),
  //               ),
  //               RichText(
  //                 text: TextSpan(
  //                   text: "Voulez-vous vraiment vous déconnecter?",
  //                   style: StyleText().greyFont,
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomRight,
  //                 child: ElevatedButton(
  //                   style: ButtonStyle(
  //                     backgroundColor: MaterialStateProperty.all(
  //                       mbSeconderedColorKbe,
  //                     ),
  //                     shape: MaterialStateProperty.all(
  //                       RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(5),
  //                       ),
  //                     ),
  //                   ),
  //                   onPressed: onTap,
  //                   child: RichText(
  //                     text: TextSpan(
  //                       text: "OUI",
  //                       style: StyleText().primaryStyle.copyWith(color: mwhite),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  //
//recuperer la premiere lettre
  String getFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase();
  }

// set color to user profile following the first letter
  Color setColor(String name) {
    var value = getFirstLetter(name);
    if (value == 'B' || value == 'L' || value == 'U' || value == 'E') {
      return mred;
    } else if (value == 'O' || value == 'R' || value == 'N') {
      return mColor4;
    } else if (value == 'G') {
      return mColor6;
    } else if (value == 'A' || value == 'M') {
      return mbSecondebleuColorKbe;
    } else if (value == 'C' || value == 'Y') {
      return const Color.fromARGB(255, 2, 77, 87);
    } else if (value == 'D' || value == 'P' || value == 'I') {
      return Colors.deepPurple;
    } else if (value == 'T') {
      return Colors.teal;
    } else {
      return mblack;
    }
  }
}
