import 'package:admin/components/action_widget.dart';
import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/function.dart';
import 'package:flutter/material.dart';

class EventHoverChild extends StatelessWidget {
  const EventHoverChild({
    super.key,
    this.onDel,
    this.onEdit,
  });
  final void Function()? onDel, onEdit;

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
                    "Vous êtes supprimer cette annonce, continuer ? ",
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
