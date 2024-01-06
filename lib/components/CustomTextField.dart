import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Color color; // Ajouté pour permettre la personnalisation de la couleur

  CustomTextField({
    required this.hintText,
    this.obscureText = false,
    required this.color, // Ajouté pour permettre la personnalisation de la couleur
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        cursorColor: color, // Modifié pour utiliser la couleur personnalisée
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: color), // Modifié pour utiliser la couleur personnalisée
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: color), // Modifié pour utiliser la couleur personnalisée
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: color), // Modifié pour utiliser la couleur personnalisée
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: color), // Modifié pour utiliser la couleur personnalisée
          ),
        ),
        style: TextStyle(
            color: color), // Modifié pour utiliser la couleur personnalisée
        obscureText: obscureText,
      ),
    );
  }
}
