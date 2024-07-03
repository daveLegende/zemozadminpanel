import 'package:admin/constant.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: width / 5,
          decoration: BoxDecoration(
            color: mbSeconderedColorKbe,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              color: mwhite,
            ),
          )),
        ),
      ),
    );
  }
}
