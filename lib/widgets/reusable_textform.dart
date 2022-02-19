import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReUsableTextFormField extends StatelessWidget {
  const ReUsableTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
