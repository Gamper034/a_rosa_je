import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';

// ignore: must_be_immutable
class ToastError extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final double height;
  final VoidCallback onPressedConfirm;

  // Variables pour le thème
  final Color backgroundColor = Colors.white;
  final Color confirmColor = Colors.red;
  final Color confirmTextColor = Colors.white;
  final Color iconColor = Colors.red;
  final Color titleColor = textColor;
  final Color contentColor = textColor;

  ToastError({
    required this.title,
    required this.content,
    required this.icon,
    required this.height,
    required this.onPressedConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: iconColor,
              size: 48,
            ),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: contentColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: onPressedConfirm,
              label: "Fermer",
              buttonColor: confirmColor,
              textColor: confirmTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
