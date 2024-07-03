import 'package:admin/blocs/matchs/match_bloc.dart';
import 'package:admin/blocs/teams/teams_bloc.dart';
import 'package:admin/blocs/poules/poules_bloc.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/navigate_controller.dart';
import 'package:admin/function.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/match_model.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'components/calendar_widget.dart';
import 'components/match_all_widget.dart';
import 'components/match_form.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final navigationController = Get.find<NavigationController>();
  late TeamsBloc tbloc = BlocProvider.of<TeamsBloc>(context);
  late MatchBloc mbloc = BlocProvider.of<MatchBloc>(context);
  late PoulesBloc pbloc = BlocProvider.of<PoulesBloc>(context);

  @override
  void initState() {
    super.initState();
    mbloc.add(GetMatchsSuccessEvent());
    tbloc.add(GetTeamSuccessEvent());
    pbloc.add(GetPouleSuccessEvent());
    mbloc.stream.listen((state) {
      if (state is CreateMatchsSuccessState) {
        Helper().showToast(state.message, context);
        mbloc.add(GetMatchsSuccessEvent());
      } else if (state is CreateMatchsErrorState) {
        Helper().showToast(state.error, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<PoulesBloc, PoulesState>(builder: (context, pState) {
      return BlocBuilder<TeamsBloc, TeamsState>(builder: (context, tState) {
        return BlocBuilder<MatchBloc, MatchState>(builder: (context, state) {
          if (state is GetMatchsSuccessState &&
              tState is GetTeamSuccessState &&
              pState is GetPouleSuccessState) {
            List<MatchModel> liveMatches = state.matchs
                .where((match) => match.etat == "EN_COURS")
                .toList();
            List<MatchModel> finishedMatches = state.matchs
                .where((match) => match.etat == "TERMINER")
                .toList();
            List<MatchModel> upcomingMatches =
                state.matchs.where((match) => match.etat == "A_VENIR").toList();

            print(upcomingMatches.length);
            return Container(
              color: mBeige,
              child: Obx(() {
                return Column(
                  children: [
                    HeaderAndButton(
                      title: "Liste des matchs",
                      onPressed: () {
                        MesFunctions().addDialog(
                          context: context,
                          title: "CREER UN MATCH",
                          width: width / 2,
                          height: height * .7,
                          child: MatchForm(
                            teams: tState.teams,
                            mState: state,
                            poules: pState.poules,
                          ),
                        );
                      },
                    ),
                    // SizedBox(height: defaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MatchRubriqueWidget(
                            text: "Matchs en cours",
                            color: mbSeconderedColorKbe,
                            boxShadow:
                                navigationController.selectedIndex.value == 0
                                    ? monShadow
                                    : [],
                            style: navigationController.selectedIndex.value == 0
                                ? StyleText().transStyle
                                : TextStyle(),
                            onTap: () {
                              navigationController.changeIndex(0);
                            },
                          ),
                          MatchRubriqueWidget(
                            text: "Calendrier des machs",
                            color: primaryColor,
                            boxShadow:
                                navigationController.selectedIndex.value == 1
                                    ? monShadow
                                    : [],
                            style: navigationController.selectedIndex.value == 1
                                ? StyleText().transStyle
                                : TextStyle(),
                            onTap: () {
                              navigationController.changeIndex(1);
                            },
                          ),
                          MatchRubriqueWidget(
                            text: "Matchs terminés",
                            color: mred,
                            boxShadow:
                                navigationController.selectedIndex.value == 2
                                    ? monShadow
                                    : [],
                            style: navigationController.selectedIndex.value == 2
                                ? StyleText().transStyle
                                : TextStyle(),
                            onTap: () {
                              navigationController.changeIndex(2);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    Expanded(
                      child: Container(
                        width: width,
                        child: navigationController.selectedIndex.value == 0
                            ? GridWidget(
                                matchs: liveMatches,
                                type: "EN_COURS",
                              )
                            : navigationController.selectedIndex.value == 1
                                ? CalendarWidget(matchs: upcomingMatches)
                                : GridWidget(
                                    matchs: finishedMatches,
                                    type: "TERMINER",
                                  ),
                      ),
                    ),
                  ],
                );
              }),
            );
          } else {
            return ChargementText();
          }
        });
      });
    });
  }
}

class MatchRubriqueWidget extends StatelessWidget {
  const MatchRubriqueWidget({
    super.key,
    required this.text,
    required this.color,
    this.boxShadow,
    this.onTap,
    required this.style,
  });
  final String text;
  final Color color;
  final List<BoxShadow>? boxShadow;
  final TextStyle style;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          boxShadow: boxShadow,
        ),
        child: Center(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(color: mwhite),
          ),
        ),
      ),
    );
  }
}
