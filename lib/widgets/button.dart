import 'package:flutter/material.dart';
// import 'package:a_rosa_je/constants.dart';
import 'package:a_rosa_je/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color
      buttonColor; // Ajouté pour permettre la personnalisation de la couleur du bouton
  final Color
      textColor; // Ajouté pour permettre la personnalisation de la couleur du texte
  final IconData? icon;

  CustomButton({
    required this.onPressed,
    required this.label,
    this.buttonColor =
        Colors.white, // Par défaut, la couleur du bouton est blanche
    this.textColor =
        primaryColor, // Par défaut, la couleur du texte est la couleur primaire de l'application
    this.icon,
  });
//OutlinedButton
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor, side: BorderSide.none),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: icon != null
              ? Row(
                  // Si icon est fourni, affichez une Row avec l'icône et le texte
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(color: textColor),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      icon,
                      color: textColor,
                    ),
                  ],
                )
              : Text(
                  label,
                  style: TextStyle(color: textColor),
                ), // Sinon, affichez simplement le texte
        ),
      ),
    );
  }
}
