import 'package:admin/components/action_widget.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:admin/models/admin.dart';
import 'package:admin/services/repositeries/repositeries.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminTableWidget extends StatefulWidget {
  const AdminTableWidget({
    super.key,
    required this.admins,
  });
  final List<Admin> admins;

  @override
  State<AdminTableWidget> createState() => _AdminTableWidgetState();
}

class _AdminTableWidgetState extends State<AdminTableWidget> {
  final repo = Get.find<ApiRepositeries>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final repo = Get.find<ApiRepositeries>();
    return widget.admins.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              width: size.width / 3,
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
                    label: Text('Email'),
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
                  widget.admins.length,
                  (i) {
                    final admin = widget.admins[i];
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          admin.email,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              MesFunctions().deleteorStopDialog(
                                context: context,
                                title: "Suppression",
                                content:
                                    "Voulez-vous vraiment supprimer cet admin ${admin.email}",
                                buttonText: "Supprimer",
                                onDel: () {
                                  repo
                                      .deleteAdmin(
                                    admin: admin,
                                    context: context,
                                  )
                                      .then(
                                    (value) {
                                      Navigator.of(context).pop();
                                      value
                                          ? setState(() {
                                              widget.admins.removeAt(i);
                                            })
                                          : null;
                                    },
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  mbSeconderedColorKbe),
                            ),
                            child: Text(
                              "Supprimer",
                              style: TextStyle(
                                color: mwhite,
                              ),
                            ),
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
