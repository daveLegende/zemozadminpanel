import 'package:admin/components/action_widget.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/constant.dart';
import 'package:admin/function.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class UserTableWidget extends StatefulWidget {
  const UserTableWidget({
    super.key,
    required this.users,
  });
  final List<UserModel> users;

  @override
  State<UserTableWidget> createState() => _UserTableWidgetState();
}

class _UserTableWidgetState extends State<UserTableWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final repo = Get.find<ApiRepositeries>();
    return widget.users.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              width: size.width,
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
                    label: Text('Nom'),
                    // size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('Contact'),
                  ),
                  DataColumn(
                    label: Text('Solde'),
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
                  widget.users.length,
                  (i) {
                    final user = widget.users[i];
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          user.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataCell(
                          Text(
                            user.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(Text(
                          user.phone,
                          textAlign: TextAlign.center,
                        )),
                        DataCell(Text(
                          Helper().formatMontant(double.parse(user.solde)),
                          textAlign: TextAlign.center,
                        )),
                        DataCell(
                          ActionWidget(
                            onDel: () {
                              MesFunctions().deleteorStopDialog(
                                context: context,
                                title: "Suppression",
                                content:
                                    "Voulez-vous vraiment supprimer ${user.username} ? ",
                                buttonText: "Supprimer",
                                onDel: () {
                                  // repo
                                  //     .deleteTeam(team: team, context: context)
                                  //     .then((value) {
                                  //   Navigator.of(context).pop();
                                  //   value
                                  //       ? setState(() {
                                  //           widget.teams.removeAt(i);
                                  //         })
                                  //       : null;
                                  // });
                                },
                              );
                              // equipes.removeAt(i);

                              // Navigator.pop(context);
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
}
