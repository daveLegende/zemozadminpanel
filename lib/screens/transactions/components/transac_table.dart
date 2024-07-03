import 'package:admin/components/action_widget.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/constant.dart';
import 'package:admin/function.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/transaction.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class TransactionTable extends StatelessWidget {
  const TransactionTable({
    super.key,
    required this.transacs,
  });
  final List<TransactionModel> transacs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return transacs.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              width: size.width,
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
                    label: Text('Type de transaction'),
                    // size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Rechargeur'),
                  ),
                  DataColumn(
                    label: Text('Client'),
                  ),
                  DataColumn(
                    label: Text('Somme'),
                  ),
                  DataColumn(
                    label: Text('Date'),
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
                  transacs.length,
                  (i) {
                    final trans = transacs[i];
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          trans.type,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataCell(
                          Text(
                            trans.admin.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            trans.user.email,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            Helper().formatMontant(double.parse(trans.amount)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            Helper().formatDate(DateTime.parse(trans.date)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          ActionWidget(
                            onDel: () {
                              MesFunctions().deleteorStopDialog(
                                context: context,
                                title: "Suppression",
                                content:
                                    "Voulez-vous vraiment supprimer cette transaction ? ",
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
            text:
                "Aucune transaction trouvée dans la base...veuillez réessayer",
          );
  }
}
