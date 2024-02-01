import 'package:a_rosa_je/theme/color.dart';
import 'package:flutter/material.dart';

TextStyle white = TextStyle(color: Colors.white);

// class LocationTextStyle {
//   static final baseTextStyle = GoogleFonts.getFont('Raleway').copyWith(
//     color: LocationStyle.colorPurple,
//   );

//   static final regularTextStyle = baseTextStyle.copyWith(
//     fontSize: 13,
//   );

//   static final regularWhiteTextStyle = baseTextStyle.copyWith(
//     color: Colors.white70,
//   );

//   static final priceTextStyle = baseTextStyle.copyWith(
//     color: Colors.white70,
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//   );

//   static final priceGreyTextStyle = priceTextStyle.copyWith(
//     color: Colors.grey,
//   );

//   static final regularGreyTextStyle = baseTextStyle.copyWith(
//     color: Colors.grey,
//     fontSize: 13,
//   );

//   static final boldTextStyle = baseTextStyle.copyWith(
//     fontWeight: FontWeight.bold,
//   );

//   static final subTitleboldTextStyle = baseTextStyle.copyWith(
//     fontWeight: FontWeight.bold,
//     fontSize: 16,
//   );
// }

class ArosajeTextStyle {
  static final baseTextStyle = TextStyle(
    fontFamily: 'Inter',
  );

  static final regularTextStyle = baseTextStyle.copyWith(
    fontSize: 13,
  );

  static final regularWhiteTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
  );

  static final regularGreyTextStyle = baseTextStyle.copyWith(
    color: Colors.grey,
    fontSize: 13,
  );

  static final boldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
  );

  static final subTitleboldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final AppBarTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: greenSolid,
  );

  static final titleFormTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: contentColor,
  );

  static final labelFormTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static final contentTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: contentColor,
  );

  static final contentSecondaryTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: secondaryTextColor,
  );

  static final titleLightTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: greyColor,
  );

  static final secondarySubTitle = baseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: secondaryTextColor,
  );
}
