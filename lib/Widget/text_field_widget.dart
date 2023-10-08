import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      this.validator,
      required this.hintText,
      required this.controller,
      this.maxLength,
      this.maxLines,
      this.keyboardType});

  final FormFieldValidator? validator;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: TextFormField(
          validator: validator,
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
              ))),
    );
  }
}
