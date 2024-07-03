import 'dart:io';

import 'package:admin/api/url.dart';
import 'package:admin/blocs/teams/teams_bloc.dart';
import 'package:admin/components/action_widget.dart';
import 'package:admin/components/buttons/save_button.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/general_field.dart';
import 'package:admin/components/team_flag_name.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TeamTableWidget extends StatefulWidget {
  const TeamTableWidget({
    super.key,
    required this.teams,
  });
  final List<EquipeModel> teams;

  @override
  State<TeamTableWidget> createState() => _TeamTableWidgetState();
}

class _TeamTableWidgetState extends State<TeamTableWidget> {
  final repo = Get.find<ApiRepositeries>();
  File? image;
  final picker = ImagePicker();
  Uint8List webImage = Uint8List(0);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return widget.teams.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              // padding: EdgeInsets.all(defaultPadding),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: mwhite,
                borderRadius: BorderRadius.circular(5),
              ),
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => mbSeconderedColorKbe,
                ),
                columns: [
                  DataColumn(
                    label: Text('Logo'),
                    // size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Nom'),
                  ),
                  DataColumn(
                    label: Text('Commune'),
                  ),
                  DataColumn(
                    label: Text('Coach'),
                  ),
                  DataColumn(
                    label: Text('Joueurs'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('Bts Marqués'),
                  ),
                  DataColumn(
                    label: Text('Bts Concédés'),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: StyleText()
                          .googleTitre
                          .copyWith(color: mbSecondebleuColorKbe),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  widget.teams.length,
                  (i) {
                    final team = widget.teams[i];
                    return DataRow(
                      cells: [
                        DataCell(TeamLogo(path: team.logo)),
                        DataCell(Text(
                          team.nom,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(
                          team.commune,
                          textAlign: TextAlign.center,
                        )),
                        DataCell(Text(
                          team.coach,
                          textAlign: TextAlign.center,
                        )),
                        DataCell(
                          Text(
                            "${team.joueurs.length}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(Text(
                          team.nombreButsMarques.toString(),
                          textAlign: TextAlign.center,
                        )),
                        DataCell(Text(
                          team.nombreButsConcedes.toString(),
                          textAlign: TextAlign.center,
                        )),
                        DataCell(
                          ActionWidget(
                            onDel: () {
                              MesFunctions().deleteorStopDialog(
                                context: context,
                                title: "Suppression",
                                content:
                                    "Voulez-vous vraiment supprimer l'élément sélectionné ? ",
                                buttonText: "Supprimer",
                                onDel: () {
                                  repo
                                      .deleteTeam(team: team, context: context)
                                      .then((value) {
                                    Navigator.of(context).pop();
                                    value
                                        ? setState(() {
                                            widget.teams.removeAt(i);
                                          })
                                        : null;
                                  });
                                },
                              );
                              // equipes.removeAt(i);

                              // Navigator.pop(context);
                            },
                            onEdit: () {
                              final nom = TextEditingController(text: team.nom);
                              final commune =
                                  TextEditingController(text: team.commune);
                              final coach =
                                  TextEditingController(text: team.coach);
                              List<TextEditingController> joueurs =
                                  List.generate(
                                      team.joueurs.length,
                                      (i) => TextEditingController(
                                          text: team.joueurs[i]));
                              MesFunctions().addDialog(
                                context: context,
                                title: "MODIFIER UNE EQUIPE",
                                width: width / 1.5,
                                height: height,
                                child: StatefulBuilder(
                                    builder: (context, mySetState) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Wrap(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      spacing: 20, // spacing between children
                                      runSpacing: 20, // spacing between lines
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Logo de l'équipe : ",
                                              style: StyleText()
                                                  .greyFont
                                                  .copyWith(color: mblack),
                                            ),
                                            Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor: mgrey[200],
                                                  backgroundImage: webImage
                                                          .isNotEmpty
                                                      ? MemoryImage(webImage)
                                                      : NetworkImage(
                                                          "${APIURL.imgUrl}${team.logo}")
                                                          as ImageProvider<
                                                              Object>,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      chooseImage(mySetState);
                                                    },
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: bgColor,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        TextAndFieldColumn(
                                            title: "Nom de l'équipe",
                                            controller: nom,
                                            hint: "Saisir le nom",
                                            width: width),
                                        TextAndFieldColumn(
                                            title: "Commune",
                                            controller: commune,
                                            hint: "Saisir la commune",
                                            width: width),
                                        TextAndFieldColumn(
                                            title: "Nom du coach",
                                            controller: coach,
                                            hint: "coach",
                                            width: width),
                                        Wrap(
                                          spacing: 20,
                                          runSpacing: 20,
                                          children: List.generate(
                                            team.joueurs.length,
                                            (index) {
                                              return TextAndFieldColumn(
                                                  title: "Joueur ${index + 1}",
                                                  controller: joueurs[index],
                                                  hint: "Joueurs",
                                                  width: width);
                                            },
                                          ),
                                        ),
                                        SaveButton(
                                          text: "Enrégistrer l'équipe",
                                          onTap: () {
                                            repo
                                                .updateTeam(
                                              context: context,
                                              image: webImage,
                                              equipe: EquipeModel(
                                                id: team.id!,
                                                nom: nom.text.trim(),
                                                logo: image!.path,
                                                coach: coach.text.trim(),
                                                joueurs: joueurs
                                                    .map((e) => e.text.trim())
                                                    .toList(),
                                                commune: commune.text.trim(),
                                              ),
                                            )
                                                .then(
                                              (value) {
                                                if (value) {
                                                  final teamBloc = BlocProvider
                                                      .of<TeamsBloc>(context);
                                                  teamBloc.add(
                                                      GetTeamSuccessEvent());
                                                  Navigator.pop(context);
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        : ErrorText(
            text: "Aucune équipe trouvée dans la base...veuillez réessayer",
          );
  }

  chooseImage(void Function(void Function()) state) async {
    if (!kIsWeb) {
      var imagePicker = await picker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        state(() {
          image = File(imagePicker.path);
        });
      } else {
        print("No image has not picked");
      }
    } else if (kIsWeb) {
      var imagePicker = await picker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        var f = await imagePicker.readAsBytes();
        state(() {
          webImage = f;
          image = File("a");
        });
      } else {
        print("No image has not picked");
      }
    } else {
      print("Platform unknow");
    }
  }
}

class TextAndFieldColumn extends StatelessWidget {
  const TextAndFieldColumn({
    super.key,
    required this.title,
    required this.width,
    required this.hint,
    required this.controller,
  });
  final double width;
  final String title, hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          width: width / 5,
          child: GeneralTextField(
            controller: controller,
            prefixIcon: Icon(Icons.title),
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
