import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

// small style
TextStyle getSmallStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// Meduim Style
TextStyle getMeduimStyle({
  double fontSize = FontSize.s16,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// large style
TextStyle getRegularStyle({
  double fontSize = FontSize.s20,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getlargeStyle({
  double fontSize = FontSize.s30,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// // Reguler Style
// TextStyle getRegulerStyle({
//   double fontSize = FontSize.s12,
//   required Color color,
// }) {
//   return _getTextStyle(fontSize, FontWeightManager.light, color);
// }

// // Light Style
// TextStyle getLightStyle({
//   double fontSize = FontSize.s12,
//   required Color color,
// }) {
//   return _getTextStyle(fontSize, FontWeightManager.light, color);
// }

// // Bold Style
// TextStyle getBoldStyle({
//   double fontSize = FontSize.s12,
//   required Color color,
// }) {
//   return _getTextStyle(fontSize, FontWeightManager.bold, color);
// }

// // SemiBold Style
// TextStyle getSemiBoldStyle({
//   double fontSize = FontSize.s12,
//   required Color color,
// }) {
//   return _getTextStyle(fontSize, FontWeightManager.bold, color);
// }
