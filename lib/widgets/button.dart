import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color buttonColor;
  final Color textColor;
  final IconData? icon;
  final bool border;

  CustomButton({
    required this.onPressed,
    required this.label,
    this.buttonColor = Colors.white,
    this.textColor = primaryColor,
    this.icon,
    this.border = false,
  });
//OutlinedButton
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonColor,
        side: border
            ? BorderSide(color: secondaryColor, width: 2.0)
            : BorderSide.none,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
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
                ),
        ),
      ),
    );
  }
}
