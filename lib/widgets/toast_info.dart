import 'package:a_rosa_je/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:a_rosa_je/theme/theme.dart';

// ignore: must_be_immutable
class ToastInfo extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final double height;
  String? theme;
  final VoidCallback onPressedConfirm;

  // Variables pour le thème
  final Color backgroundColor;
  final Color confirmColor;
  final Color confirmTextColor;
  final Color iconColor;
  final Color titleColor;
  final Color contentColor;

  ToastInfo({
    this.theme = "light",
    required this.title,
    required this.content,
    required this.icon,
    required this.height,
    required this.onPressedConfirm,
  })  : backgroundColor = theme == 'light' ? Colors.white : primaryColor,
        confirmColor = theme == 'light' ? primaryColor : Colors.white,
        confirmTextColor = theme == 'light' ? Colors.white : primaryColor,
        iconColor = theme == 'light' ? primaryColor : Colors.white,
        titleColor = theme == 'light' ? textColor : Colors.white,
        contentColor = theme == 'light' ? textColor : Colors.white;

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
