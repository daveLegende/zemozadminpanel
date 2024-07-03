import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin/constant.dart';
import 'package:admin/style.dart';

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    super.key,
    this.validator,
    required this.controller,
    this.onChanged,
    this.suffixIcon,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
  });

  final String hintText;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: mgrey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          style: StyleText().googleTitre,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: StyleText().googleTitre.copyWith(color: mgrey),
            // labelText: "Nom",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  const FormFields({
    super.key,
    this.validator,
    required this.controller,
    this.onChanged,
    required this.hintText,
    this.inputFormatters,
    this.keyboardType,
  });

  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: StyleText().googleTitre,
      cursorColor: bgColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: StyleText().googleTitre.copyWith(color: mgrey),
        // labelText: "Nom",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
