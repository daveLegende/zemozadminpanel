import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

class ButtonCreate extends StatefulWidget {
  const ButtonCreate({
    super.key,
    required this.label,
    this.onPressed,
  });
  final String label;
  final Function()? onPressed;

  @override
  State<ButtonCreate> createState() => _ButtonCreateState();
}

class _ButtonCreateState extends State<ButtonCreate> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
      ),
      onPressed: widget.onPressed,
      icon: Icon(Icons.add, color: mwhite),
      label: Text(
        widget.label,
        style: TextStyle(color: mwhite),
      ),
    );
  }
}

class CustomElevatedB extends StatelessWidget {
  const CustomElevatedB({
    super.key,
    this.onPressed,
    required this.text,
    required this.color,
  });
  final Function()? onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: mwhite),
      ),
    );
  }
}
