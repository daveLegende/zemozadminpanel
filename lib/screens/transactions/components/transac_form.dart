import 'package:admin/blocs/transactions/transactions_bloc.dart';
import 'package:admin/components/buttons/save_button.dart';
import 'package:admin/components/loading.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/helper.dart';
import 'package:admin/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransacForm extends StatefulWidget {
  const TransacForm({super.key, required this.width});
  final double width;

  @override
  State<TransacForm> createState() => _TransacFormState();
}

class _TransacFormState extends State<TransacForm> {
  String statusText = 'Choisir';
  final phone = TextEditingController();
  final montant = TextEditingController();
  final pass = TextEditingController();

  late TransactionsBloc tbloc = BlocProvider.of<TransactionsBloc>(context);
  Offset? tapPosition;

  void initReset(void setState(void Function() fn)) {
    setState(() {
      statusText = "Choisir";
      phone.clear();
      pass.clear();
      montant.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
        return BlocListener<TransactionsBloc, TransactionsState>(
          listener: (context, state) {
            if (state is DepotErrorState) {
              Helper().myErrorToast(state.error, context);
            } else if (state is RetraitErrorState) {
              Helper().myErrorToast(state.error, context);
            } else if (state is DepotSuccessState) {
              Helper().mySuccessToast(state.message, context);
              initReset(setState);
            } else if (state is RetraitSuccessState) {
              Helper().mySuccessToast(state.message, context);
              initReset(setState);
            }
          },
          child: BlocBuilder<TransactionsBloc, TransactionsState>(
              builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Type de transaction"),
                            InkWell(
                              onTapDown: (details) {
                                setState(() {
                                  tapPosition = details.globalPosition;
                                });
                                showPopupMenu(
                                  context: context,
                                  setState: setState,
                                );
                              },
                              child: Container(
                                width: widget.width / 2.3,
                                height: 50,
                                color: mgrey[200],
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      statusText,
                                      style: StyleText().googleTitre.copyWith(
                                            color: statusText == "Choisir"
                                                ? mgrey
                                                : mblack,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Numéro du client"),
                            CustomTextField(
                              controller: phone,
                              hintText: "Entrez le numéro",
                              icon: Icons.phone,
                              inputFormatters: inputFormaters,
                              width: widget.width / 2.3,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Montant de la transaction"),
                            CustomTextField(
                              controller: montant,
                              hintText: "Entrez le montant",
                              icon: Icons.money,
                              inputFormatters: inputFormaters,
                              width: widget.width / 2.3,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mot de passe"),
                            CustomTextField(
                              controller: pass,
                              hintText: "Entrez le passe",
                              icon: CupertinoIcons.lock_fill,
                              width: widget.width / 2.3,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2 * defaultPadding),
                    state is DepotLoadingState || state is RetraitLoadingState
                        ? LoadingCircular()
                        : SaveButton(
                            text: "Effectuer la transaction",
                            onTap: () {
                              if (statusText == depot) {
                                tbloc.add(
                                  DepotSuccessEvent(
                                    amount: montant.text.trim(),
                                    phone: phone.text.trim(),
                                    password: pass.text.trim(),
                                  ),
                                );
                              } else {
                                tbloc.add(
                                  RetraitSuccessEvent(
                                    amount: montant.text.trim(),
                                    phone: phone.text.trim(),
                                    password: pass.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),
                  ],
                ),
              );
          },),
        );
      }
    );
  }

  void showPopupMenu(
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
          value: depot,
          child: Text(depot),
        ),
        PopupMenuItem<String>(
          value: retrait,
          child: Text(retrait),
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
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.width,
    this.inputFormatters,
  });

  final String hintText;
  final IconData icon;
  final double width;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      child: TextFormField(
        controller: controller,
        style: StyleText().googleTitre,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: mgrey),
          filled: true,
          fillColor: mgrey[200],
          prefixIcon: Icon(
            icon,
            color: mgrey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
