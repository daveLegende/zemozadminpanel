import 'dart:io';

import 'package:admin/blocs/teams/teams_bloc.dart';
import 'package:admin/components/buttons/submit_button..dart';
import 'package:admin/components/forms/form_fields.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/components/loading.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EquipeForm extends StatefulWidget {
  const EquipeForm({
    super.key,
    required this.commune,
    required this.coach,
    required this.name,
    required this.joueurs,
    this.image,
    required this.webImage,
    required this.nbreJoueur,
    required this.state,
    required this.teamBloc,
    this.onChooseImage,
  });
  final TextEditingController commune;
  final TextEditingController coach;
  final TextEditingController name;
  final List<TextEditingController> joueurs;
  final int nbreJoueur;
  final File? image;
  final Uint8List webImage;
  final TeamsState state;
  final TeamsBloc teamBloc;
  final void Function()? onChooseImage;

  @override
  State<EquipeForm> createState() => _EquipeFormState();
}

class _EquipeFormState extends State<EquipeForm> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final name = widget.name;
    final commune = widget.commune;
    final coach = widget.coach;
    final nbreJoueur = widget.nbreJoueur;
    final image = widget.image;
    final joueurs = widget.joueurs;
    final webImage = widget.webImage;
    return HeaderAndButton(
      title: "Liste des Equipes",
      onPressed: () {
        MesFunctions().addDialog(
          context: context,
          title: "Ajouter une équipe",
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
                        style: StyleText().greyFont.copyWith(color: mblack),
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: mgrey[200],
                            backgroundImage: image == null
                                ? AssetImage("assets/logos/default_logo.png")
                                : kIsWeb
                                    ? MemoryImage(webImage)
                                    : FileImage(
                                        File(
                                          image.path,
                                        ),
                                      ) as ImageProvider<Object>,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: widget.onChooseImage,
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
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: defaultPadding),
                  widget.state is AddTeamLoadingState
                      ? LoadingCircular()
                      : SubmitButton(
                          text: "Enrégistrer l'équipe",
                          onTap: () {
                            widget.teamBloc.add(
                              AddTeamSuccessEvent(
                                image: webImage,
                                equipe: EquipeModel(
                                  nom: name.text.trim(),
                                  logo: image!.path,
                                  coach: coach.text.trim(),
                                  joueurs: List.generate(
                                    nbreJoueur,
                                    (i) => joueurs[i].text.trim(),
                                  ),
                                  commune: commune.text.trim(),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
