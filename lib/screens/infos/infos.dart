import 'dart:io';
import 'package:admin/api/url.dart';
import 'package:admin/blocs/events/event_bloc.dart';
import 'package:admin/components/buttons/save_button.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/general_field.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/components/hover/hover_container.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/event.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'components/event_hover.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  File? image;
  final picker = ImagePicker();
  Uint8List webImage = Uint8List(0);
  final title = TextEditingController();
  final desc = TextEditingController();
  late EventBloc ebloc = BlocProvider.of<EventBloc>(context);
  final repo = Get.find<ApiRepositeries>();

  @override
  void initState() {
    super.initState();
    ebloc.add(GetEventSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is GetEventSuccessState) {
          return Container(
            width: width,
            height: height - appBarHeight,
            child: Column(
              children: [
                HeaderAndButton(
                  title: "Les informations du tournoi",
                  onPressed: () {
                    MesFunctions().addDialog(
                      context: context,
                      title: "CREER UNE ANNONCE",
                      width: width / 2,
                      height: height / 1.5,
                      child: StatefulBuilder(builder: (context, setState) {
                        return Container(
                          margin: EdgeInsets.only(top: defaultPadding),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Choisir une image :",
                                          style: TextStyle(color: mblack),
                                        ),
                                        SizedBox(width: defaultPadding),
                                        InkWell(
                                          onTap: () {
                                            chooseImage(setState);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: mgrey[100],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: image == null
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        color: bgColor,
                                                      ),
                                                      Text("Ajouter"),
                                                    ],
                                                  )
                                                : Image.memory(
                                                    webImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Le titre de l'annonce"),
                                        GeneralTextField(
                                          controller: title,
                                          prefixIcon: Icon(Icons.title),
                                          hintText: "Saisissez un titre",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: defaultPadding),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Laissez des informations supplémentaires",
                                    style: TextStyle(),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: desc,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      labelText: "commentaires...",
                                      hintText: "commentaires...",
                                      hintStyle: TextStyle(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: bgColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: bgColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2 * defaultPadding),
                              SaveButton(
                                text: "Enrégistrer l'annonce",
                                onTap: () {
                                  repo
                                      .addEvent(
                                    event: EventModel(
                                      title: title.text.trim(),
                                      desc: desc.text.trim(),
                                      image: image!.path,
                                    ),
                                    image: webImage,
                                    context: context,
                                  )
                                      .then((value) {
                                    if (value) {
                                      ebloc.add(GetEventSuccessEvent());
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: defaultPadding,
                      left: defaultPadding,
                      right: defaultPadding,
                    ),
                    child: state.events.isEmpty
                        ? ErrorText(
                            text: "Aucune information trouvé dans la base.",
                          )
                        : GridView.builder(
                            padding: EdgeInsets.only(bottom: 20),
                            itemCount: state.events.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (context, i) {
                              final events = state.events;
                              final event = events[i];
                              return HoverContainer(
                                hoverChild: EventHoverChild(
                                  onDel: () {
                                    repo
                                        .deleteEvent(
                                      event: event,
                                      context: context,
                                    )
                                        .then(
                                      (value) {
                                        if (value) {
                                          setState(() {
                                            events.remove(event);
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  },
                                  onEdit: () {
                                    final titre = TextEditingController(
                                        text: event.title);
                                    final description =
                                        TextEditingController(text: event.desc);
                                    MesFunctions().addDialog(
                                      context: context,
                                      title: "MODIFIER UNE ANNONCE",
                                      onDismiss: () {
                                        setState(() {
                                          webImage = Uint8List(0);
                                        });
                                      },
                                      width: width / 2,
                                      height: height / 1.5,
                                      child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: defaultPadding),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Choisir une image :",
                                                            style: TextStyle(
                                                                color: mblack),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  defaultPadding),
                                                          InkWell(
                                                            onTap: () {
                                                              chooseImage(
                                                                  setState);
                                                            },
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    mgrey[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: webImage
                                                                      .isEmpty
                                                                  ? Image
                                                                      .network(
                                                                      "${APIURL.imgUrl}${event.image}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image
                                                                      .memory(
                                                                      webImage,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Le titre de l'annonce",
                                                          ),
                                                          GeneralTextField(
                                                            controller: titre,
                                                            prefixIcon: Icon(
                                                                Icons.title),
                                                            hintText:
                                                                "Saisissez un titre",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: defaultPadding),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Laissez des informations supplémentaires",
                                                      style: TextStyle(),
                                                    ),
                                                    SizedBox(height: 10),
                                                    TextFormField(
                                                      controller: description,
                                                      maxLines: 3,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "commentaires...",
                                                        hintText:
                                                            "commentaires...",
                                                        hintStyle: TextStyle(),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      bgColor),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      bgColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: 2 * defaultPadding),
                                                SaveButton(
                                                  text: "Enrégistrer l'annonce",
                                                  onTap: () {
                                                    repo
                                                        .updateEvent(
                                                      event: EventModel(
                                                        id: event.id,
                                                        title:
                                                            titre.text.trim(),
                                                        desc: description.text
                                                            .trim(),
                                                        image: image!.path,
                                                      ),
                                                      image: webImage,
                                                      context: context,
                                                    )
                                                        .then((value) {
                                                      if (value) {
                                                        setState(() {
                                                          webImage =
                                                              Uint8List(0);
                                                        });
                                                        ebloc.add(
                                                            GetEventSuccessEvent());
                                                        Navigator.pop(context);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                child: Card(
                                  elevation: 10,
                                  color: mwhite,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: double.infinity,
                                            child: Image.network(
                                              "${APIURL.imgUrl}${event.image}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            color: mwhite,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  event.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  event.desc,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    color: mgrey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ChargementText();
        }
      },
    );
  }

  chooseImage(void Function(void Function()) state) async {
    if (!kIsWeb) {
      var imagePicker = await picker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        setState(() {
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
