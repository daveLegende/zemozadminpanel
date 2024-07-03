import 'package:admin/blocs/poules/poules_bloc.dart';
import 'package:admin/blocs/teams/teams_bloc.dart';
import 'package:admin/components/buttons/save_button.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/general_field.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/components/hover/hover_container.dart';
import 'package:admin/components/team_flag_name.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/models/poules.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import 'components/hover_poule_child.dart';

class PouleScreen extends StatefulWidget {
  const PouleScreen({super.key});

  @override
  State<PouleScreen> createState() => _PouleScreenState();
}

class _PouleScreenState extends State<PouleScreen> {
  final nom = TextEditingController();
  final equipe1 = TextEditingController();
  final equipe2 = TextEditingController();
  final equipe3 = TextEditingController();
  final equipe4 = TextEditingController();
  final controller = Get.find<ApiRepositeries>();
  List<String> teams = [];
  late PoulesBloc pouleBloc = BlocProvider.of<PoulesBloc>(context);

  @override
  void initState() {
    super.initState();
    final teamBloc = BlocProvider.of<TeamsBloc>(context);
    // Ajouter l'écouteur de flux une seule fois
    teamBloc.add(GetTeamSuccessEvent());
    pouleBloc.add(GetPouleSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<TeamsBloc, TeamsState>(builder: (context, tState) {
      return BlocBuilder<PoulesBloc, PoulesState>(builder: (context, pState) {
        if (pState is GetPouleSuccessState && tState is GetTeamSuccessState) {
          final poules = pState.poules;
          final myTeams = tState.teams;

          // Appeler calculerClassement() pour chaque poule
          for (PouleModel poule in poules) {
            poule.calculerClassement();
          }
          return Container(
            color: mBeige,
            child: Column(
              children: [
                HeaderAndButton(
                  title: "Liste des Poules",
                  onPressed: () {
                    MesFunctions().addDialog(
                      context: context,
                      title: "CREATION DE POULE",
                      width: width / 2,
                      height: height * 1.2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Choisir le nom de la poule",
                                  style: TextStyle(
                                      color: mblack,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(width: defaultPadding),
                                Container(
                                  width: width / 5,
                                  child: FormFields(
                                    controller: nom,
                                    hintText: "Ex: Poule A",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: TeamFields(
                                    controller: equipe1,
                                    label: "Equipe 1",
                                    bTeams: myTeams,
                                    onSuggestionTap: (team) {
                                      print(team.item!.id);
                                      setState(() {
                                        teams.add(team.item!.id!);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(
                                  child: TeamFields(
                                    controller: equipe2,
                                    label: "Equipe 2",
                                    bTeams: tState.teams,
                                    onSuggestionTap: (team) {
                                      print(team.item!.id);
                                      setState(() {
                                        teams.add(team.item!.id!);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: TeamFields(
                                    controller: equipe3,
                                    label: "Equipe 3",
                                    bTeams: tState.teams,
                                    onSuggestionTap: (team) {
                                      print(team.item!.id);
                                      setState(() {
                                        teams.add(team.item!.id!);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(
                                  child: TeamFields(
                                    controller: equipe4,
                                    label: "Equipe 4",
                                    bTeams: tState.teams,
                                    onSuggestionTap: (team) {
                                      print(team.item!.logo);
                                      setState(() {
                                        teams.add(team.item!.id!);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            SaveButton(
                              text: "Enrégistrer la poule",
                              onTap: () {
                                controller
                                    .addPoule(
                                  context: context,
                                  nom: nom.text.trim(),
                                  equipes: teams.map((e) => e).toList(),
                                )
                                    .then((value) {
                                  controller.pb.value == true
                                      ? pouleBloc.add(GetPouleSuccessEvent())
                                      : () {};
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: poules.isNotEmpty
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          margin: EdgeInsets.only(bottom: defaultPadding),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: poules.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: defaultPadding,
                              mainAxisSpacing: defaultPadding,
                              childAspectRatio: size.width < 1400 ? 1.5 : 1.5,
                            ),
                            itemBuilder: (context, index) {
                              final poule = poules[index];
                              return HoverContainer(
                                hoverChild: HoverPouleChild(
                                  onDel: () {
                                    controller
                                        .deletePoule(
                                      poule: poule,
                                      context: context,
                                    )
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      if (value) {
                                        setState(() {
                                          poules.remove(poule);
                                        });
                                      }
                                    });
                                  },
                                  onEdit: () {},
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: double.infinity,
                                    height: width / 4,
                                    decoration: BoxDecoration(
                                      color: mwhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: bgColor.withOpacity(.5),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 10,
                                                  child: Text(
                                                    poule.nom,
                                                    style: StyleText()
                                                        .whiteTextSmall
                                                        .copyWith(
                                                            color: mblack),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child: Text("MJ"),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child: Text("BM"),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child: Text("BC"),
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child: Text(
                                                        "Pts",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: poule.equipes
                                                .map(
                                                  (equipe) => Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                                    color: equipe.position == 1
                                                        ? mColor5
                                                            .withOpacity(.3)
                                                        : equipe.position == 2
                                                            ? mbSeconderedColorKbe
                                                                .withOpacity(.3)
                                                            : mtransparent,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 10,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 20,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${equipe.position}.",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              TeamLogo(
                                                                  path:
                                                                      "${equipe.logo}"),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                equipe.nom,
                                                                style: StyleText()
                                                                    .googleTitre
                                                                    .copyWith(
                                                                      color:
                                                                          mblack,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Text(
                                                                equipe
                                                                    .nombreMatchsJoues
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Text(
                                                                equipe
                                                                    .nombreButsMarques
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Text(
                                                                equipe
                                                                    .nombreButsConcedes
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Text(
                                                                "${equipe.points}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : ErrorText(text: "Aucune poule disponible..."),
                ),
              ],
            ),
          );
        } else {
          return ChargementText();
        }
      });
    });
  }

  void init() {
    setState(() {
      equipe1.text = "";
      equipe2.text = "";
      equipe3.text = "";
      equipe4.text = "";
      // equipes = [];
      nom.text = "";
    });
  }
}

class TeamFields extends StatelessWidget {
  const TeamFields({
    super.key,
    required this.controller,
    required this.label,
    this.onSuggestionTap,
    required this.bTeams,
  });
  final String label;
  final TextEditingController controller;
  final dynamic Function(SearchFieldListItem<EquipeModel>)? onSuggestionTap;
  final List<EquipeModel> bTeams;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          decoration: BoxDecoration(
            color: mgrey[100],
            borderRadius: BorderRadius.circular(2),
          ),
          child: SearchField<EquipeModel>(
            controller: controller,
            marginColor: mgrey[100],
            onSuggestionTap: onSuggestionTap,
            suggestionsDecoration: SuggestionDecoration(
              color: mwhite,
            ),
            searchInputDecoration: InputDecoration(
              hintText: "Choisir l'équipe",
              prefixIcon: SizedBox(),
              hintStyle: StyleText().googleTitre.copyWith(color: mgrey),
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
            searchStyle: StyleText().googleTitre,
            suggestions: bTeams
                .map(
                  (e) => SearchFieldListItem<EquipeModel>(
                    e.nom,
                    item: e,
                    // Use child to show Custom Widgets in the suggestions
                    // defaults to Text widget
                    child: Container(
                      color: mwhite,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TeamLogo(path: e.logo),
                          SizedBox(width: 10),
                          Text(
                            e.nom,
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
