import 'package:a_rosa_je/theme/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Color color;
  final Color colorText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Color? errorColor;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int minLines;

  CustomTextField({
    required this.hintText,
    this.obscureText = false,
    required this.color,
    this.onSaved,
    this.validator,
    this.errorColor,
    this.onTap,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
    this.colorText = greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        cursorColor: color,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: colorText),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.5, color: color),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.5, color: color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.5, color: color),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.5, color: errorColor ?? Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.5, color: errorColor ?? Colors.red),
          ),
          errorStyle: TextStyle(color: errorColor),
        ),
        style: TextStyle(fontWeight: FontWeight.w300, color: color),
        obscureText: obscureText,
        onSaved: onSaved,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
      ),
    );
  }
}
