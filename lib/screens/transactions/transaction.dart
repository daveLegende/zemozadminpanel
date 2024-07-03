import 'package:admin/blocs/transac/transac_bloc.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/header_and_button.dart';
// import 'package:admin/constants.dart';
import 'package:admin/function.dart';
// import 'package:admin/screens/chargement.dart';
import 'package:admin/screens/transactions/components/transac_form.dart';
import 'package:admin/screens/transactions/components/transac_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Parametre extends StatefulWidget {
  const Parametre({super.key});

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  late TransacBloc tbloc = BlocProvider.of<TransacBloc>(context);
  @override
  void initState() {
    super.initState();
    tbloc.add(GetAllTransacSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      child: Column(
        children: [
          HeaderAndButton(
            title: "La liste des transactions effectuées",
            onPressed: () {
              MesFunctions().addDialog(
                context: context,
                title: "Rechargement et Retrait",
                height: height / 2,
                width: width / 2.5,
                child: TransacForm(
                  width: width / 2.5,
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<TransacBloc, TransacState>(
              builder: (context, state) {
                if (state is GetAllTransacSuccessState) {
                  return TransactionTable(
                    transacs: state.transacs,
                  );
                } else if (state is GetAllTransacErrorState) {
                  return ErrorText(text: "Transactions non disponible",);
                } else {
                  return ChargementText();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
