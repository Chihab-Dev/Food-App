import 'package:flutter/material.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.white,
    splashColor: ColorManager.orange,

    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: AppSize.s4,
      color: ColorManager.orange,
      iconTheme: IconThemeData(color: ColorManager.white),
      titleTextStyle: getMeduimStyle(color: ColorManager.white),
    ),

    // bottom theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.ligthGrey,
      buttonColor: ColorManager.white,
      splashColor: ColorManager.orange,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMeduimStyle(color: ColorManager.white, fontSize: FontSize.s17),
        backgroundColor: ColorManager.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      // displayLarge: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
      // headlineLarge: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
      // headlineMedium: getRegulerStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
      titleMedium: getMeduimStyle(color: ColorManager.white, fontSize: FontSize.s16),
      titleSmall: getSmallStyle(color: ColorManager.grey, fontSize: FontSize.s16),
      labelSmall: getSmallStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      bodyLarge: getlargeStyle(color: ColorManager.white),
      bodySmall: getSmallStyle(color: ColorManager.grey),
      bodyMedium: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s12),
    ),

    // input decoration theme ( text form field )
    inputDecorationTheme: InputDecorationTheme(
      // icon color
      iconColor: ColorManager.orange,

      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      // hint style
      hintStyle: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // label style
      labelStyle: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // error style
      errorStyle: getMeduimStyle(color: ColorManager.red, fontSize: FontSize.s14),

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.ligthGrey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.orange, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
