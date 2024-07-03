import 'package:admin/blocs/listAdmin/admin_list_bloc.dart';
import 'package:admin/components/chargement_text.dart';
import 'package:admin/components/header_and_button.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/admin_table.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late AdminListBloc abloc = BlocProvider.of<AdminListBloc>(context);

  @override
  void initState() {
    super.initState();
    abloc.add(GetListAdminSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return BlocBuilder<AdminListBloc, AdminListState>(
      builder: (context, state) {
        return Container(
          color: mBeige,
          child: Column(
            children: [
              HeaderAndButton(
                title: "Liste des administrateurs",
                onPressed: () {},
              ),
              SizedBox(height: defaultPadding),
              Expanded(
                child: state is GetListAdminSuccessState
                    ? AdminTableWidget(admins: state.admins)
                    : ChargementText(),
              ),
            ],
          ),
        );
      },
    );
  }
}
