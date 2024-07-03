import 'package:admin/components/action_widget.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/hover/hover_container.dart';
import 'package:admin/components/team_flag_name.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/match_model.dart';
import 'package:admin/screens/matchs/components/add_event_match.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/services/repositeries/socket_repo.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({
    super.key,
    required this.matchs,
    required this.type,
    this.onDel,
    this.onEdit,
  });
  final String type;
  final List<MatchModel> matchs;
  final void Function()? onDel, onEdit;

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  final score1 = TextEditingController();
  final score2 = TextEditingController();
  final butteur = TextEditingController();
  final repo = Get.find<ApiRepositeries>();
  final repo_socket = Get.find<RepoSocket>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: widget.matchs.isEmpty
          ? Container(
              height: height / 2,
              child: ErrorText(text: "Aucun Match disponible"),
            )
          : Wrap(
              spacing: 20,
              runSpacing: 20,
              children: widget.matchs.map((e) {
                score1.text = e.scores['equipeDomicile'].toString();
                score2.text = e.scores['equipeExterieure'].toString();
                if (e.etat == widget.type) {
                  return MatchGridItem(
                    type: widget.type,
                    match: e,
                    onDel: () {
                      repo_socket
                          .startOrEndMatch(
                        context: context,
                        matchId: e.id!,
                        matchState: "TERMINER",
                      )
                          .then((value) {
                        Navigator.of(context).pop();
                        setState(() {
                          widget.matchs.remove(e);
                        });
                      });
                      // repo
                      //     .stopMatch(matchId: e.id!, context: context)
                      //     .then((value) {
                      //   Navigator.of(context).pop();
                      //   setState(() {
                      //     widget.matchs.remove(e);
                      //   });
                      // });
                    },
                    onEdit: () {
                      MesFunctions().addDialog(
                        context: context,
                        title: "EVENEMENTS DU MATCH",
                        width: width / 2,
                        height: height / 1.5,
                        child: MatchEventDuring(
                          // team: e.home,
                          match: e,
                        ),
                        // child: Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Expanded(
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               EquipeFlagName(
                        //                 radius: 20,
                        //                 logo: e.home.logo,
                        //                 name: e.home.nom,
                        //               ),
                        //               ScoreWidget(
                        //                 controller: score1,
                        //               ),
                        //               Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     "Butteur",
                        //                     style: TextStyle(),
                        //                   ),
                        //                   Container(
                        //                     height: 50,
                        //                     padding: EdgeInsets.only(
                        //                       left: defaultPadding,
                        //                     ),
                        //                     color: mgrey[200],
                        //                     child: SearchField<String>(
                        //                       controller: butteur,
                        //                       onSuggestionTap: (teams) {
                        //                         print(teams.item!);
                        //                         setState(() {
                        //                           butteur.text = teams.item!;
                        //                         });
                        //                       },
                        //                       suggestionsDecoration:
                        //                           SuggestionDecoration(
                        //                         color: mwhite,
                        //                       ),
                        //                       searchInputDecoration:
                        //                           InputDecoration(
                        //                         hintText: "Butteur",
                        //                         hintStyle:
                        //                             TextStyle(color: mgrey),
                        //                         focusedBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide.none,
                        //                         ),
                        //                         enabledBorder:
                        //                             UnderlineInputBorder(
                        //                           borderSide: BorderSide.none,
                        //                         ),
                        //                         border: UnderlineInputBorder(
                        //                           borderSide: BorderSide.none,
                        //                         ),
                        //                       ),
                        //                       suggestions: e.home.joueurs
                        //                           .map(
                        //                             (e) => SearchFieldListItem<
                        //                                 String>(
                        //                               e,
                        //                               item: e,
                        //                               // Use child to show Custom Widgets in the suggestions
                        //                               // defaults to Text widget
                        //                               child: Container(
                        //                                 color: mwhite,
                        //                                 padding:
                        //                                     const EdgeInsets
                        //                                         .all(
                        //                                   8.0,
                        //                                 ),
                        //                                 child: Text(e),
                        //                               ),
                        //                             ),
                        //                           )
                        //                           .toList(),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         SizedBox(width: 10),
                        //         // Expanded(
                        //         //   child: Column(
                        //         //     mainAxisAlignment: MainAxisAlignment.center,
                        //         //     children: [
                        //         //       EquipeFlagName(
                        //         //         radius: 20,
                        //         //         logo: e.away.logo,
                        //         //         name: e.away.nom,
                        //         //       ),
                        //         //       ScoreWidget(
                        //         //         controller: score2,
                        //         //       ),
                        //         //     ],
                        //         //   ),
                        //         // ),
                        //         Expanded(
                        //           child: MatchEventDuring(
                        //             team: e.away,
                        //             controller: TextEditingController(),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(height: 2 * defaultPadding),
                        //     InkWell(
                        //       onTap: () {
                        //         print("web socket-----------------");
                        //         final matchBloc =
                        //             BlocProvider.of<MatchBloc>(context);
                        //         matchBloc.add(
                        //           MatchsUpdateSocketSuccessEvent(
                        //             message: "Match update successfuly",
                        //             matchId: e.id!,
                        //             homeScore: score1.text.trim(),
                        //             awayScore: score2.text.trim(),
                        //             aFautes: "0",
                        //             aButeurs: [],
                        //             aJaune: "0",
                        //             aCorners: "0",
                        //             aPasseurs: [],
                        //             aRouge: "0",
                        //             hFautes: "0",
                        //             hButeurs: [],
                        //             hJaune: "0",
                        //             hCorners: "0",
                        //             hPasseurs: [],
                        //             hRouge: "0",
                        //           ),
                        //         );
                        //         matchBloc.add(GetMatchsSuccessEvent());
                        //         Navigator.pop(context);
                        //       },
                        //       child: Container(
                        //         height: 50,
                        //         width: width / 4,
                        //         decoration: BoxDecoration(
                        //           color: mbSeconderedColorKbe,
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Center(
                        //           child: Text(
                        //             "Mettre à jour",
                        //             style: TextStyle(color: mwhite),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }).toList(),
            ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.color = mwhite,
    // required this.hintText,
  });
  // final String hintText;
  final Color? color;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mwhite,
      elevation: 10,
      shadowColor: bgColor,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.only(left: 15),
        child: Center(
          child: TextField(
            controller: controller,
            style:
                StyleText().transStyle.copyWith(color: mbSecondebleuColorKbe),
            decoration: InputDecoration(
              // prefixIcon: Container(),
              // hintText: hintText,
              // labelText: "Nom",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class MatchGridItem extends StatelessWidget {
  const MatchGridItem({
    super.key,
    required this.match,
    this.onDel,
    this.onEdit,
    required this.type,
  });
  final String type;
  final MatchModel match;
  final void Function()? onDel, onEdit;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return HoverContainer(
      onHoverEnter: () {
        print("On hover enter");
      },
      onHoverExit: () {
        print("On hover enter");
      },
      onTap: () {},
      child: Container(
        height: height / 4,
        width: width / 4,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: mwhite,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tournoi Zemoz",
                  style: StyleText().greyFont.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Edition Gamma",
                  style:
                      StyleText().tabFont.copyWith(color: mbSeconderedColorKbe),
                ),
              ],
            ),
            Text(
              match.type,
              style: StyleText().minime,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: EquipeFlagName(
                    radius: 20,
                    logo: match.home.logo,
                    name: match.home.nom,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${match.scores['equipeDomicile']} : ${match.scores['equipeExterieure']}",
                      style: StyleText().primaryFont,
                    ),
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
                type == "TERMINER" ? "Terminé" : "match en cours",
                style: type == "TERMINER"
                    ? StyleText().googleTitre.copyWith(
                          color: mred,
                        )
                    : StyleText().minime.copyWith(
                          color: mColor5,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationThickness: 5,
                          decorationStyle: TextDecorationStyle.dotted,
                          decorationColor: mColor5,
                        ),
              ),
            ),
          ],
        ),
      ),
      hoverChild: type == "TERMINER"
          ? null
          : AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: Row(
                children: [
                  ItemAction(
                    color: bgColor,
                    icon: Icons.edit,
                    size: 40,
                    iconSize: 20,
                    onTap: onEdit,
                  ),
                  SizedBox(width: defaultPadding),
                  ItemAction(
                    color: mred,
                    icon: Icons.stop_circle,
                    size: 40,
                    iconSize: 20,
                    onTap: () {
                      MesFunctions().deleteorStopDialog(
                        context: context,
                        title: "Arreter",
                        content:
                            "Voulez êtes entrain de stopper le match, continuer ? ",
                        buttonText: "Stopper",
                        onDel: onDel,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
