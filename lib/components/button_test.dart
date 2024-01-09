import 'package:flutter/material.dart';
//import de tout le dossier theme dans lib
import 'package:a_rosa_je/theme/theme.dart';

class TextfieldLog extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const TextfieldLog({
    super.key,
    required this.validator,
    required this.controller,
  });

  @override
  State<TextfieldLog> createState() => _TextfieldLogState();
}

class _TextfieldLogState extends State<TextfieldLog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        autocorrect: false,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          hintText: "Nom d'utilisateur",
          hintStyle: TextStyle(color: secondaryColor),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}

class SecretTextfield extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const SecretTextfield(
      {super.key, required this.validator, required this.controller});

  @override
  State<SecretTextfield> createState() => _SecretTextfieldState();
}

class _SecretTextfieldState extends State<SecretTextfield> {
  bool _obscureText = true;

  void _visibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextFormField(
        obscuringCharacter: "*",
        controller: widget.controller,
        autocorrect: false,
        validator: widget.validator,
        obscureText: _obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          hintText: "Mot de passe",
          hintStyle: TextStyle(color: secondaryColor),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            onPressed: _visibility,
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
