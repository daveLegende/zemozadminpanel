import 'package:admin/components/action_widget.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/hover/hover_container.dart';
import 'package:admin/components/team_flag_name.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/match_model.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/services/repositeries/socket_repo.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
    required this.matchs,
  });
  final List<MatchModel> matchs;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final repo = Get.find<ApiRepositeries>();
  final repo_socket = Get.find<RepoSocket>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final matchs = widget.matchs;
    List<List<MatchModel>> groupedMatches = Helper().groupMatchesByDate(matchs);
    return matchs.isEmpty
        ? ErrorText(text: "Aucun match disponible")
        : ListView.builder(
            itemCount: groupedMatches.length,
            itemBuilder: (_, i) {
              final match = matchs[i];
              List<MatchModel> matchesForDate = groupedMatches[i];
              return match.etat == "A_VENIR"
                  ? Container(
                      height: height / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            color: bgColor.withOpacity(.4),
                            margin:
                                EdgeInsets.symmetric(vertical: defaultPadding),
                            padding:
                                const EdgeInsets.only(left: defaultPadding),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Helper().dateEcole(DateTime.parse(match.date.toString())),
                                style: StyleText().tabFont,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: matchesForDate.length,
                              itemBuilder: (_, i) {
                                final match = matchesForDate[i];
                                return Container(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right:
                                        i == matchesForDate.length - 1 ? 10 : 0,
                                    left: i == 0 ? 15 : 10,
                                  ),
                                  child: HoverContainer(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Helper().goTo(
                                        //   context: context,
                                        //   page: MatchDetails(match: match),
                                        // );
                                      },
                                      child: Card(
                                        elevation: 10,
                                        child: Container(
                                          width: width / 4,
                                          // height: width / 2,
                                          decoration: BoxDecoration(
                                            color: mwhite,
                                            // border: Border.all(
                                            //   color: mColor5,
                                            // ),
                                            // borderRadius:
                                            //     BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Tournoi Zemoz",
                                                    style: StyleText()
                                                        .greyFont
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        match.lieu,
                                                      ),
                                                      Icon(
                                                        Icons.location_on,
                                                        color: mred
                                                            .withOpacity(.3),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  match.type,
                                                  style: StyleText().minime,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: EquipeFlagName(
                                                      radius: 20,
                                                      logo: match.home.logo,
                                                      name: match.home.nom,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "VS",
                                                      style: StyleText()
                                                          .primaryFont,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: EquipeFlagName(
                                                      radius: 20,
                                                      logo: match.away.logo,
                                                      name: match.away.nom,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Heure : ${Helper().afficherHeureMinute(
                                                    DateTime.parse(match.date.toString()),
                                                  )}",
                                                  style: StyleText()
                                                      .googleTitre
                                                      .copyWith(
                                                        color: mColor5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    hoverChild: AnimatedContainer(
                                      duration: const Duration(seconds: 2),
                                      child: Row(
                                        children: [
                                          ItemAction(
                                            color: bgColor,
                                            icon: Icons.play_circle,
                                            size: 40,
                                            iconSize: 20,
                                            onTap: () {
                                              MesFunctions().deleteorStopDialog(
                                                context: context,
                                                title: "Débuter le match",
                                                content:
                                                    "Vous êtes en train de lancer le début du match, continuer ? ",
                                                buttonText: "Continuer",
                                                onDel: () {
                                                  repo_socket
                                                      .startOrEndMatch(
                                                    context: context,
                                                    matchId: match.id!,
                                                    matchState: "EN_COURS",
                                                  )
                                                      .then((value) {
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      widget.matchs
                                                          .remove(match);
                                                    });
                                                  });
                                                  // repo
                                                  //     .beginMatch(
                                                  //   matchId: match.id!,
                                                  //   context: context,
                                                  // )
                                                  //     .then((value) {
                                                  //   if (value) {
                                                  //     matchs.remove(match);
                                                  //     Navigator.pop(context);
                                                  //   }
                                                  // });
                                                },
                                              );
                                            },
                                          ),
                                          SizedBox(width: defaultPadding),
                                          ItemAction(
                                            color: mred,
                                            icon: Icons.delete,
                                            size: 40,
                                            iconSize: 20,
                                            onTap: () {
                                              MesFunctions().deleteorStopDialog(
                                                context: context,
                                                title: "Suppression",
                                                content:
                                                    "Vous êtes supprimer le match selectionné, continuer ? ",
                                                buttonText: "Supprimer",
                                                onDel: () {
                                                  repo
                                                      .deleteMatch(
                                                    matchId: match.id!,
                                                    context: context,
                                                  )
                                                      .then((value) {
                                                    if (value) {
                                                      matchs.remove(match);
                                                      Navigator.pop(context);
                                                    }
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container();
            },
          );
  }
}
