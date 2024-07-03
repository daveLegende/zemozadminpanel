import 'dart:io';

import 'package:admin/blocs/teams/teams_bloc.dart';
import 'package:admin/components/buttons/submit_button..dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/forms/form_fields.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/components/loading.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/screens/equipes/components/team_table.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EquipeScreen extends StatefulWidget {
  const EquipeScreen({super.key});

  @override
  State<EquipeScreen> createState() => _EquipeScreenState();
}

class _EquipeScreenState extends State<EquipeScreen> {
  final name = TextEditingController();
  final commune = TextEditingController();
  final coach = TextEditingController();
  final nbres = TextEditingController();
  List<TextEditingController> joueurs = [];
  List<String> mesPlayers = [];
  int nbreJoueur = 0;
  File? image;
  final picker = ImagePicker();
  Uint8List webImage = Uint8List(8);
  final t_controller = Get.find<ApiRepositeries>();

  @override
  void initState() {
    super.initState();
    joueurs = List.generate(nbreJoueur, (index) => TextEditingController());
    final teamBloc = BlocProvider.of<TeamsBloc>(context);
    teamBloc.add(GetTeamSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    joueurs.addAll(List.generate(15, (_) => TextEditingController()));
    final teamBloc = BlocProvider.of<TeamsBloc>(context);
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        return Container(
          color: mBeige,
          child: Column(
            children: [
              HeaderAndButton(
                title: "Liste des Equipes",
                onPressed: () {
                  MesFunctions().addDialog(
                    context: context,
                    title: "AJOUTER UNE EQUIPE",
                    width: width / 1.5,
                    height: height,
                    child: StatefulBuilder(builder: (context, mySetState) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 20, // spacing between children
                          runSpacing: 20, // spacing between lines
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      backgroundImage: image == null
                                          ? AssetImage(
                                              "assets/logos/default_logo.png")
                                          : kIsWeb
                                              ? MemoryImage(webImage)
                                              : FileImage(
                                                  File(
                                                    image!.path,
                                                  ),
                                                ) as ImageProvider<Object>,
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
                            TextAndFieldWidget(
                              text: "Nom de l'équipe",
                              controller: name,
                              hintText: "Saisir le nom",
                            ),
                            TextAndFieldWidget(
                              text: "Commune",
                              controller: commune,
                              hintText: "Saisir la commune",
                            ),
                            TextAndFieldWidget(
                              text: "Nom du coach",
                              controller: coach,
                              hintText: "coach",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Le nombre de joueur dans l'équipe: ",
                                  style: StyleText().googleTitre,
                                ),
                                Container(
                                  width: width / 10,
                                  child: TextFormField(
                                    controller: nbres,
                                    inputFormatters: inputFormaters,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Ex: 11",
                                      hintStyle:
                                          StyleText().googleTitre.copyWith(
                                                color: mgrey,
                                                fontSize: 13,
                                              ),
                                      filled: true,
                                      fillColor: mgrey[200],
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onChanged: (val) {
                                      if (val.isEmpty) {
                                        mySetState(() {
                                          nbreJoueur = 0;
                                          joueurs = List.generate(
                                            nbreJoueur,
                                            (index) => TextEditingController(),
                                          );
                                        });
                                      } else {
                                        mySetState(() {
                                          nbreJoueur = int.parse(val);
                                          joueurs = List.generate(
                                            nbreJoueur,
                                            (index) => TextEditingController(),
                                          );
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: List.generate(
                                nbreJoueur,
                                (index) {
                                  return TextAndFieldWidget(
                                    text: "Joueur ${index + 1}",
                                    hintText: "Nom du joueur ${index + 1}",
                                    controller: joueurs[index],
                                    // onChanged: (val) {
                                    //   mySetState(() {
                                    //     mesPlayers.add(val.trim());
                                    //   });
                                    // },
                                  );
                                },
                              ),
                            ),
                            Obx(
                              () {
                                return t_controller.tmsg.value == loading
                                    ? LoadingCircular()
                                    : SubmitButton(
                                        text: "Enrégistrer l'équipe",
                                        onTap: () {
                                          t_controller.addTeam(
                                            context: context,
                                            image: webImage,
                                            equipe: EquipeModel(
                                              nom: name.text.trim(),
                                              logo: image!.path,
                                              coach: coach.text.trim(),
                                              joueurs: joueurs.map((e) => e.text.trim()).toList(),
                                              commune: commune.text.trim(),
                                            ),
                                          );
                                          teamBloc.add(GetTeamSuccessEvent());
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
              SizedBox(height: defaultPadding),
              Expanded(
                child: state is GetTeamSuccessState
                    ? TeamTableWidget(teams: state.teams)
                    : ChargementText(),
              ),
            ],
          ),
        );
      },
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

  void init() {
    image = File("");
    nbreJoueur = 0;
    nbres.text = "";
    commune.text = "";
    name.text = "";
    coach.text = "";
    joueurs = [];
  }
}

// class SourceTable extends DataTableSource {
//   SourceTable(this.onDel);
//   final Callback? onDel;
//   @override
//   DataRow? getRow(int index) {
//     final team = equipes[index];
//     return DataRow(
//       color: MaterialStateColor.resolveWith((states) => mwhite),
//       cells: [
//         DataCell(TeamLogo(path: team.logo)),
//         DataCell(Text(
//           team.nom,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         )),
//         DataCell(Text(team.commune)),
//         DataCell(Text("Aucun")),
//         DataCell(Text("Aucun")),
//         DataCell(Text(team.nombreButsMarques.toString())),
//         DataCell(Text(team.nombreMatchsJoues.toString())),
//         DataCell(
//           ActionWidget(
//             onDel: onDel,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => equipes.length;

//   @override
//   int get selectedRowCount => 0;
// }
