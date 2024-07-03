import 'package:admin/components/action_widget.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:flutter/material.dart';

class HoverPouleChild extends StatelessWidget {
  const HoverPouleChild({
    super.key,
    this.onEdit,
    this.onDel,
  });
  final void Function()? onEdit, onDel;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      child: Row(
        children: [
          ItemAction(
            color: bgColor,
            icon: Icons.edit,
            size: 40,
            iconSize: 20,
            onTap: onEdit,
          ),
          SizedBox(width: defaultPadding),
          ItemAction(
            color: mred,
            icon: Icons.delete,
            size: 40,
            iconSize: 20,
            onTap: () {
              MesFunctions().deleteorStopDialog(
                context: context,
                title: "Suppression",
                content:
                    "vous êtes entrain de supprimer la poule sélectionnée, Continuer ?",
                buttonText: "Supprimer",
                onDel: onDel,
              );
            },
          ),
        ],
      ),
    );
  }
}
