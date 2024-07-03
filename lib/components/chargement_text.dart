import 'package:admin/constant.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class ChargementText extends StatelessWidget {
  const ChargementText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Chargement..."),
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: StyleText().googleTitre.copyWith(
              color: mred,
            ),
      ),
    );
  }
}
