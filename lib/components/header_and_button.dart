import 'package:admin/components/button.dart';
import 'package:admin/components/custom_text.dart';
import 'package:flutter/material.dart';

class HeaderAndButton extends StatelessWidget {
  const HeaderAndButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title),
          ButtonCreate(
            label: "Ajouter",
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
