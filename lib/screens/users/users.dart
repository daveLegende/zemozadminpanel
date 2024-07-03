import 'package:admin/blocs/user/user_bloc.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/user_table.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc ubloc = BlocProvider.of<UserBloc>(context);

  @override
  void initState() {
    super.initState();
    ubloc.add(GetListUsersSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          color: mBeige,
          child: Column(
            children: [
              HeaderAndButton(
                title: "Liste des utilisateurs",
                onPressed: () {
                  // MesFunctions().addDialog(
                  //   context: context,
                  //   title: "Ajouter un utilisateur",
                  //   width: width / 1.5,
                  //   height: height,
                  //   child: StatefulBuilder(builder: (context, mySetState) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(top: 10),
                  //       child: Wrap(
                  //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         spacing: 20, // spacing between children
                  //         runSpacing: 20, // spacing between lines
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 "Logo de l'équipe : ",
                  //                 style: StyleText()
                  //                     .greyFont
                  //                     .copyWith(color: mblack),
                  //               ),
                  //               Stack(
                  //                 children: [
                  //                   CircleAvatar(
                  //                     radius: 50,
                  //                     backgroundColor: mgrey[200],
                  //                     backgroundImage: image == null
                  //                         ? AssetImage(
                  //                             "assets/logos/default_logo.png")
                  //                         : kIsWeb
                  //                             ? MemoryImage(webImage)
                  //                             : FileImage(
                  //                                 File(
                  //                                   image!.path,
                  //                                 ),
                  //                               ) as ImageProvider<Object>,
                  //                   ),
                  //                   Positioned(
                  //                     bottom: 0,
                  //                     right: 0,
                  //                     child: InkWell(
                  //                       onTap: () {
                  //                         chooseImage(mySetState);
                  //                       },
                  //                       child: Icon(
                  //                         Icons.camera_alt,
                  //                         color: bgColor,
                  //                         size: 40,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //           TextAndFieldWidget(
                  //             text: "Nom de l'équipe",
                  //             controller: name,
                  //             hintText: "Saisir le nom",
                  //           ),
                  //           TextAndFieldWidget(
                  //             text: "Commune",
                  //             controller: commune,
                  //             hintText: "Saisir la commune",
                  //           ),
                  //           TextAndFieldWidget(
                  //             text: "Nom du coach",
                  //             controller: coach,
                  //             hintText: "coach",
                  //           ),
                  //           Wrap(
                  //             spacing: 20,
                  //             runSpacing: 20,
                  //             children: List.generate(
                  //               nbreJoueur,
                  //               (index) {
                  //                 return TextAndFieldWidget(
                  //                   text: "Joueur ${index + 1}",
                  //                   hintText: "Nom du joueur ${index + 1}",
                  //                   controller: joueurs[index],
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //           Obx(
                  //             () {
                  //               return t_controller.tmsg.value == loading
                  //                   ? LoadingCircular()
                  //                   : SubmitButton(
                  //                       text: "Enrégistrer l'équipe",
                  //                       onTap: () {
                  //                         t_controller.addTeam(
                  //                           context: context,
                  //                           image: webImage,
                  //                           equipe: EquipeModel(
                  //                             nom: name.text.trim(),
                  //                             logo: image!.path,
                  //                             coach: coach.text.trim(),
                  //                             joueurs: List.generate(
                  //                               nbreJoueur,
                  //                               (i) => joueurs[i].text.trim(),
                  //                             ),
                  //                             commune: commune.text.trim(),
                  //                           ),
                  //                         );
                  //                         teamBloc.add(GetTeamSuccessEvent());
                  //                       },
                  //                     );
                  //             },
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   }),
                  // );
                },
              ),
              SizedBox(height: defaultPadding),
              Expanded(
                child: state is GetListUsersSuccessState
                    ? UserTableWidget(users: state.user)
                    : ChargementText(),
              ),
            ],
          ),
        );
      },
    );
  }
}
