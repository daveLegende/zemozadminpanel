import 'package:admin/blocs/matchs/match_bloc.dart';
import 'package:admin/components/buttons/save_button.dart';
import 'package:admin/components/team_flag_name.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/models/match_model.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

import 'match_all_widget.dart';

class MatchEventDuring extends StatefulWidget {
  const MatchEventDuring({
    super.key,
    // required this.team,
    required this.match,
  });

  // final EquipeModel team;
  final MatchModel match;

  @override
  State<MatchEventDuring> createState() => _MatchEventDuringState();
}

class _MatchEventDuringState extends State<MatchEventDuring> {
  TextEditingController score1 = TextEditingController();
  TextEditingController but1 = TextEditingController();
  TextEditingController temps1 = TextEditingController();
  TextEditingController score2 = TextEditingController();
  TextEditingController but2 = TextEditingController();
  TextEditingController temps2 = TextEditingController();
  TextEditingController carton1 = TextEditingController();
  TextEditingController carton2 = TextEditingController();
  TextEditingController carton_temps1 = TextEditingController();
  TextEditingController carton_temps2 = TextEditingController();

  Offset? tapPosition;
  String statusText = 'Choisir';
  String statusText2 = 'Choisir';

  int i = 0;

  @override
  void initState() {
    super.initState();
    score1.text = widget.match.scores['equipeDomicile'].toString();
    score2.text = widget.match.scores['equipeExterieure'].toString();
  }

  @override
  Widget build(BuildContext context) {
    // final team = widget.team;
    final match = widget.match;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: EquipeFlagName(
                    radius: 20,
                    logo: match.home.logo,
                    name: match.home.nom,
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
            Container(
              margin: EdgeInsets.only(top: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EventItemTabBar(
                    text: "Buts",
                    barColor: i == 0 ? bgColor : null,
                    style: i == 0
                        ? StyleText()
                            .transStyle
                            .copyWith(color: mbSeconderedColorKbe)
                        : null,
                    onTap: () {
                      setState(() {
                        i = 0;
                      });
                    },
                  ),
                  EventItemTabBar(
                    text: "Cartons",
                    barColor: i == 1 ? bgColor : null,
                    style: i == 1
                        ? StyleText()
                            .transStyle
                            .copyWith(color: mbSeconderedColorKbe)
                        : null,
                    onTap: () {
                      setState(() {
                        i = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: i == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ScoreItemForTeam(
                            score: score1,
                            butteur: but1,
                            temps: temps1,
                            alignment: Alignment.centerLeft,
                            widget: widget,
                            team: match.home,
                            onSuggestionTap: (teams) {
                              // print(teams.item!);
                              setState(() {
                                but1.text = teams.item!;
                              });
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 50),
                        //   child: Container(
                        //     margin: EdgeInsets.symmetric(
                        //       vertical: defaultPadding,
                        //       horizontal: 10,
                        //     ),
                        //     width: 1,
                        //     height: 120,
                        //     color: mgrey[200],
                        //   ),
                        // ),
                        Expanded(
                          child: ScoreItemForTeam(
                            score: score2,
                            butteur: but2,
                            temps: temps2,
                            alignment: Alignment.centerLeft,
                            widget: widget,
                            team: match.away,
                            onSuggestionTap: (teams) {
                              // print(teams.item!);
                              setState(() {
                                but2.text = teams.item!;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: CartonWidget(
                              statusText: statusText,
                              team: match.home,
                              carton: carton1,
                              carton_temps: carton_temps1,
                              onTapDown: (details) {
                                setState(() {
                                  tapPosition = details.globalPosition;
                                });
                                showPopupMenu1(
                                  context: context,
                                  setState: setState,
                                );
                              },
                              onSuggestionTap: (teams) {
                                setState(() {
                                  carton1.text = teams.item!;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: CartonWidget(
                              statusText: statusText2,
                              team: match.away,
                              carton: carton2,
                              carton_temps: carton_temps2,
                              onTapDown: (details) {
                                setState(() {
                                  tapPosition = details.globalPosition;
                                });
                                showPopupMenu2(
                                  context: context,
                                  setState: setState,
                                );
                              },
                              onSuggestionTap: (teams) {
                                setState(() {
                                  carton2.text = teams.item!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(height: 2 * defaultPadding),
            SaveButton(
              text: "Enrégistrer",
              onTap: () {
                print("web socket-----------------");
                final matchBloc = BlocProvider.of<MatchBloc>(context);
                matchBloc.add(
                  MatchEventUpdate(
                    message: "Match update successfuly",
                    matchId: match.id!,
                    homeScore: score1.text.trim(),
                    awayScore: score2.text.trim(),
                    hbj: but1.text.trim(),
                    hbt: temps1.text.trim(),
                    hcj: carton1.text.trim(),
                    hct: carton_temps1.text.trim(),
                    hcc: statusText,
                    abj: but2.text.trim(),
                    abt: temps2.text.trim(),
                    acj: carton2.text.trim(),
                    act: carton_temps2.text.trim(),
                    acc: statusText2,
                  ),
                );
                matchBloc.add(GetMatchsSuccessEvent());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     EquipeFlagName(
    //       radius: 20,
    //       logo: team.logo,
    //       name: team.nom,
    //     ),
    //     ScoreWidget(
    //       controller: widget.controller,
    //     ),
    //     Row(
    //       children: [
    //         Expanded(
    //           flex: 2,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 "Butteur",
    //                 style: TextStyle(),
    //               ),
    //               Container(
    //                 height: 50,
    //                 padding: EdgeInsets.only(
    //                   left: defaultPadding,
    //                 ),
    //                 color: mgrey[200],
    //                 child: SearchField<String>(
    //                   // controller: butteur,
    //                   onSuggestionTap: (teams) {
    //                     print(teams.item!);
    //                     // setState(() {
    //                     //   butteur.text = teams.item!;
    //                     // });
    //                   },
    //                   suggestionsDecoration: SuggestionDecoration(
    //                     color: mwhite,
    //                   ),
    //                   searchInputDecoration: InputDecoration(
    //                     hintText: "Choisir le butteur",
    //                     hintStyle: TextStyle(color: mgrey),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide.none,
    //                     ),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide.none,
    //                     ),
    //                     border: UnderlineInputBorder(
    //                       borderSide: BorderSide.none,
    //                     ),
    //                   ),
    //                   suggestions: team.joueurs
    //                       .map(
    //                         (e) => SearchFieldListItem<String>(
    //                           e,
    //                           item: e,
    //                           // Use child to show Custom Widgets in the suggestions
    //                           // defaults to Text widget
    //                           child: Container(
    //                             color: mwhite,
    //                             padding: const EdgeInsets.all(
    //                               8.0,
    //                             ),
    //                             child: Text(e),
    //                           ),
    //                         ),
    //                       )
    //                       .toList(),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           flex: 1,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 "Minuites",
    //                 style: TextStyle(),
    //               ),
    //               ScoreWidget(
    //                 controller: TextEditingController(),
    //                 color: mgrey[200],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }

  void showPopupMenu1(
      {required BuildContext context,
      required void setState(void Function() fn)}) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapPosition! & Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: yellowCard,
          child: Text(yellowCard),
        ),
        PopupMenuItem<String>(
          value: redCard,
          child: Text(redCard),
        ),
      ],
    );

    // Gérer l'option sélectionnée
    if (selected != null) {
      // print('Option sélectionnée : $selected');
      setState(() {
        statusText = selected;
      });
    }
  }

  //
  void showPopupMenu2(
      {required BuildContext context,
      required void setState(void Function() fn)}) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapPosition! & Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: yellowCard,
          child: Text(yellowCard),
        ),
        PopupMenuItem<String>(
          value: redCard,
          child: Text(redCard),
        ),
      ],
    );

    // Gérer l'option sélectionnée
    if (selected != null) {
      // print('Option sélectionnée : $selected');
      setState(() {
        statusText2 = selected;
      });
    }
  }
}

class EventItemTabBar extends StatelessWidget {
  const EventItemTabBar({
    super.key,
    this.barColor = mtransparent,
    this.onTap,
    required this.text,
    this.style = const TextStyle(color: mgrey),
  });
  final TextStyle? style;
  final String text;
  final Color? barColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              text,
              style: style,
            ),
            Container(
              width: 50,
              height: 2,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventTitle extends StatelessWidget {
  const EventTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: bgColor,
      child: Text(
        title,
        style: StyleText().googleTitre.copyWith(
              color: mwhite,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class ScoreItemForTeam extends StatelessWidget {
  const ScoreItemForTeam({
    super.key,
    required this.widget,
    required this.team,
    required this.alignment,
    required this.score,
    required this.butteur,
    required this.temps,
    this.onSuggestionTap,
  });
  final AlignmentGeometry alignment;
  final MatchEventDuring widget;
  final EquipeModel team;
  final TextEditingController score, butteur, temps;
  final dynamic Function(SearchFieldListItem<String>)? onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScoreWidget(
          controller: score,
        ),
        SizedBox(height: 10),
        Align(
          alignment: alignment,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choisir le butteur",
                      // style: StyleText().googleTitre,
                    ),
                    ChoosePlayerSearchField(
                      joueur: butteur,
                      onSuggestionTap: onSuggestionTap,
                      team: team,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Temps",
                      // style: StyleText().googleTitre,
                    ),
                    TempsWidget(temps: temps),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TempsWidget extends StatelessWidget {
  const TempsWidget({
    super.key,
    required this.temps,
  });

  final TextEditingController temps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: temps,
        style: StyleText().googleTitre,
        decoration: InputDecoration(
          filled: true,
          fillColor: mgrey[200],
          hintText: "0",
          hintStyle: TextStyle(color: mgrey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class ChoosePlayerSearchField extends StatelessWidget {
  const ChoosePlayerSearchField({
    super.key,
    required this.joueur,
    required this.onSuggestionTap,
    required this.team,
  });

  final TextEditingController joueur;
  final Function(SearchFieldListItem<String> p1)? onSuggestionTap;
  final EquipeModel team;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      padding: EdgeInsets.only(
        left: defaultPadding,
      ),
      color: mgrey[200],
      child: SearchField<String>(
        searchStyle: StyleText().googleTitre,
        controller: joueur,
        onSuggestionTap: onSuggestionTap,
        // (teams) {
        //   print(teams.item!);
        //   // setState(() {
        //   //   joueur.text = teams.item!;
        //   // });
        // },
        suggestionsDecoration: SuggestionDecoration(
          color: mwhite,
        ),
        searchInputDecoration: InputDecoration(
          hintText: "Nom du joueur",
          hintStyle: TextStyle(color: mgrey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        suggestions: team.joueurs
            .map(
              (e) => SearchFieldListItem<String>(
                e,
                item: e,
                // Use child to show Custom Widgets in the suggestions
                // defaults to Text widget
                child: Container(
                  color: mwhite,
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: Text(e),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TypeCardMenu extends StatelessWidget {
  const TypeCardMenu({super.key, required this.statusText});
  final String statusText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Type du carton"),
        SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: mgrey[200],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                statusText,
                style: statusText != "Choisir"
                    ? TextStyle()
                    : TextStyle(color: mgrey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CartonWidget extends StatelessWidget {
  const CartonWidget({
    super.key,
    required this.statusText,
    required this.team,
    required this.carton,
    required this.carton_temps,
    this.onSuggestionTap,
    this.onTapDown,
  });
  final String statusText;
  final EquipeModel team;
  final TextEditingController carton, carton_temps;
  final dynamic Function(SearchFieldListItem<String>)? onSuggestionTap;
  final void Function(TapDownDetails)? onTapDown;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTapDown: onTapDown,
                child: TypeCardMenu(
                  statusText: statusText,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Minutes"),
                  TempsWidget(temps: carton_temps),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Joueur : ",
              // style: StyleText().googleTitre,
            ),
            ChoosePlayerSearchField(
              joueur: carton,
              onSuggestionTap: onSuggestionTap,
              team: team,
            ),
          ],
        ),
      ],
    );
  }
}
