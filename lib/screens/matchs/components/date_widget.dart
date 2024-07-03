import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.dateText,
    this.onTap,
  });
  final String dateText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("La Date du match"),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            width: width / 5,
            color: mgrey[200],
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dateText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
