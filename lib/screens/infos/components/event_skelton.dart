import 'package:admin/constant.dart';
import 'package:flutter/material.dart';

class EventSkeletonizer extends StatelessWidget {
  const EventSkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height - appBarHeight,
      child: Center(
        child: Text("Chargement..."),
      ),
    );
  }
}
