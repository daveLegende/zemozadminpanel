import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({
    super.key,
    this.onEdit,
    this.onDel,
  });

  final Function()? onEdit;
  final Function()? onDel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemAction(
          icon: Icons.edit,
          color: bgColor,
          onTap: onEdit,
          // onTap: () {
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       return Align(
          //         alignment: Alignment.centerRight,
          //         child: AnimatedContainer(
          //           margin: EdgeInsets.only(
          //             top: 80,
          //             bottom: 80,
          //             left: 250,
          //             right: 80,
          //           ),
          //           duration: Duration(seconds: 1),
          //           curve: Curves.easeIn,
          //           decoration: BoxDecoration(
          //             color: mwhite,
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //         ),
          //       );
          //     },
          //   );
          // },
        ),
        SizedBox(width: 10),
        ItemAction(
          icon: Icons.delete,
          color: mbSeconderedColorKbe,
          onTap: onDel,
        ),
      ],
    );
  }
}

class ItemAction extends StatelessWidget {
  const ItemAction({
    super.key,
    required this.color,
    required this.icon,
    this.size = 30,
    this.iconSize = 10,
    this.onTap,
  });
  final Color color;
  final IconData icon;
  final double? size, iconSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: mwhite,
          ),
        ),
      ),
    );
  }
}
