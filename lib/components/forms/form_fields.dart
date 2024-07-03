import 'package:admin/components/general_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAndFieldWidget extends StatelessWidget {
  const TextAndFieldWidget({
    super.key,
    this.validator,
    required this.controller,
    this.onChanged,
    required this.hintText,
    this.inputFormatters,
    this.keyboardType,
    required this.text,
  });

  final String hintText, text;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        Container(
          width: width / 5,
          child: FormFields(
            controller: controller,
            hintText: hintText,
            validator: validator,
            onChanged: onChanged,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
