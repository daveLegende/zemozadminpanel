import 'package:admin/blocs/matchs/match_bloc.dart';
import 'package:admin/components/buttons/save_button.dart';
import 'package:admin/components/loading.dart';
import 'package:admin/components/team_flag_name.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/models/poules.dart';
import 'package:admin/screens/matchs/components/date_widget.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

class MatchForm extends StatefulWidget {
  const MatchForm({
    super.key,
    required this.teams,
    required this.mState,
    required this.poules,
  });
  final List<EquipeModel> teams;
  final List<PouleModel> poules;
  final MatchState mState;

  @override
  State<MatchForm> createState() => _MatchFormState();
}

class _MatchFormState extends State<MatchForm> {
  TextEditingController type_ctrl = TextEditingController();
  TextEditingController poule_ctrl = TextEditingController();
  TextEditingController away_ctrl = TextEditingController();
  TextEditingController home_ctrl = TextEditingController();
  EquipeModel home = constantTeam;
  EquipeModel away = constantTeam;
  PouleModel groups = constantPoule;
  Offset? tapPosition;
  String statusText = 'Type de match';
  DateTime dateTime = DateTime(2024, 4, 10, 14, 00);
  DateTime datePick = DateTime.now();
  final controller = Get.find<ApiRepositeries>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: statusText == phase_poule
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      tapPosition = details.globalPosition;
                    });
                    showPopupMenu(context);
                  },
                  child: MatchTypeWidget(
                    statusText: statusText,
                  ),
                ),
                statusText == phase_poule
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "La Poule",
                          ),
                          Container(
                            height: 50,
                            width: width / 5,
                            padding: EdgeInsets.only(left: defaultPadding),
                            decoration: BoxDecoration(color: mgrey[200]),
                            child: SearchField<PouleModel>(
                              controller: poule_ctrl,
                              onSuggestionTap: (poule) {
                                print(poule.item!.id);
                                setState(() {
                                  groups = poule.item!;
                                });
                              },
                              suggestionStyle: TextStyle(),
                              marginColor: mgrey[200],
                              searchInputDecoration: InputDecoration(
                                hintText: "Choisir la poule",
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
                              suggestionsDecoration: SuggestionDecoration(
                                color: mwhite,
                              ),
                              suggestions: widget.poules
                                  .map(
                                    (e) => SearchFieldListItem<PouleModel>(
                                      e.nom,
                                      item: e,
                                      // Use child to show Custom Widgets in the suggestions
                                      // defaults to Text widget
                                      child: Container(
                                        color: mwhite,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.nom,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      )
                    : DateWidget(
                        dateText: Helper().formatDate(datePick),
                        onTap: () async {
                          await pickDateTime(setState);
                        },
                      ),
                // statusText == phase_poule
                //     ? Container()
                //     : DateWidget(
                //         dateText: Helper().formatDate(datePick),
                //         onTap: () async {
                //           await pickDateTime();
                //         },
                //       ),
              ],
            ),
            SizedBox(height: 2 * defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Equipe à domicile"),
                    Container(
                      height: 50,
                      width: width / 5,
                      padding: EdgeInsets.only(left: defaultPadding),
                      color: mgrey[200],
                      child: SearchField<EquipeModel>(
                        controller: home_ctrl,
                        onSuggestionTap: (teams) {
                          print(teams.item!.id);
                          setState(() {
                            home = teams.item!;
                          });
                        },
                        suggestionsDecoration:
                            SuggestionDecoration(color: mwhite),
                        searchInputDecoration: InputDecoration(
                          hintText: "Choisir l'équipe",
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
                        suggestions: widget.teams
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
                                    children: [
                                      TeamLogo(path: e.logo),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(e.nom),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Equipe à l'extérieur"),
                    Container(
                      height: 50,
                      width: width / 5,
                      padding: EdgeInsets.only(left: defaultPadding),
                      color: mgrey[200],
                      child: SearchField<EquipeModel>(
                        controller: away_ctrl,
                        onSuggestionTap: (teams) {
                          print(teams.item!.id);
                          setState(() {
                            away = teams.item!;
                          });
                        },
                        suggestionsDecoration:
                            SuggestionDecoration(color: mwhite),
                        searchInputDecoration: InputDecoration(
                          hintText: "Equipe à l'extérieur",
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
                        suggestions: widget.teams
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
                                    children: [
                                      TeamLogo(path: e.logo),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(e.nom),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            statusText == phase_poule
                ? Center(
                    child: DateWidget(
                      dateText: Helper().formatDate(datePick),
                      onTap: () async {
                        await pickDateTime(setState);
                      },
                    ),
                  )
                : Container(),
            SizedBox(height: 2 * defaultPadding),
            Obx(
              () {
                return controller.mmsg.value == loading
                    ? LoadingCircular()
                    : SaveButton(
                        text: "Créer le match",
                        onTap: () {
                          controller
                              .createMatch(
                            context: context,
                            homeId: home.id!,
                            awayId: away.id!,
                            type: statusText,
                            pouleId: groups.id ?? "",
                            date: datePick.toString(),
                          )
                              .then((value) {
                            controller.mb.value == true
                                ? BlocProvider.of<MatchBloc>(context)
                                    .add(GetMatchsSuccessEvent())
                                : null;
                          });
                        },
                      );
              },
            ),
          ],
        ),
      );
    });
  }

  void showPopupMenu(BuildContext context) async {
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
          value: phase_poule,
          child: Text(phase_poule),
        ),
        PopupMenuItem<String>(
          value: seizieme,
          child: Text(seizieme),
        ),
        PopupMenuItem<String>(
          value: huitieme,
          child: Text(huitieme),
        ),
        PopupMenuItem<String>(
          value: quart,
          child: Text(quart),
        ),
        PopupMenuItem<String>(
          value: demi,
          child: Text(demi),
        ),
        PopupMenuItem<String>(
          value: finale,
          child: Text(finale),
        ),
      ],
    );

    // Gérer l'option sélectionnée
    if (selected != null) {
      print('Option sélectionnée : $selected');
      setState(() {
        statusText = selected;
      });
    }
  }

  // datetime
  Future<DateTime?> pickDate() {
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: DateTime(2050),
    );
  }

  // time
  Future<TimeOfDay?> pickTime() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
    );
  }

  // pick date and time together
  Future pickDateTime(void setState(void Function() fn)) async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;
    final newDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      datePick = newDate;
    });
  }
}

class MatchTypeWidget extends StatelessWidget {
  const MatchTypeWidget({super.key, required this.statusText});
  final String statusText;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choisir le type du match"),
        SizedBox(height: 5),
        Container(
          width: width / 5,
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
                style: statusText != "Type de match"
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
