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

  CustomButton({
    required this.onPressed,
    required this.label,
    this.buttonColor =
        Colors.white, // Par défaut, la couleur du bouton est blanche
    this.textColor =
        primaryColor, // Par défaut, la couleur du texte est la couleur primaire de l'application
  });
//OutlinedButton
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10),
    //   child: TextButton(
    //     child: Center(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 5),
    //         child: Text(
    //           label,
    //           style: TextStyle(
    //             color:
    //                 textColor, // Modifié pour utiliser la couleur personnalisée
    //             fontWeight: FontWeight.w500,
    //             fontSize: 16,
    //           ),
    //         ),
    //       ),
    //     ),
    //     onPressed: onPressed,
    //     style: TextButton.styleFrom(
    //       backgroundColor:
    //           buttonColor, // Modifié pour utiliser la couleur personnalisée
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ),
    //   ),
    // );
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor, side: BorderSide.none),
      child: Container(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          )),
    );
  }
}
