import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.whiteGrey,
    splashColor: ColorManager.orange,
    useMaterial3: true,
    iconTheme: IconThemeData(
      color: ColorManager.orange,
      size: AppSize.s25,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: AppSize.s4,
      color: ColorManager.darkOrange,
      iconTheme: IconThemeData(color: ColorManager.whiteGrey),
      titleTextStyle: getMeduimStyle(color: ColorManager.whiteGrey),
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.red,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),

    // bottom theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.ligthGrey,
      buttonColor: ColorManager.whiteGrey,
      splashColor: ColorManager.orange,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMeduimStyle(color: ColorManager.whiteGrey, fontSize: FontSize.s17),
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
      titleSmall: getSmallStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s16,
      ),
      labelSmall: getSmallStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      bodySmall: getSmallStyle(
        color: ColorManager.grey,
      ),
      titleMedium: getMeduimStyle(
        color: ColorManager.whiteGrey,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getMeduimStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s12,
      ),

      bodyLarge: getlargeStyle(
        color: ColorManager.whiteGrey,
      ),
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
