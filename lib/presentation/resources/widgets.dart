import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/resources/color_manager.dart';

import 'appsize.dart';

// Form Field ::

Widget customFormField(BuildContext context, Function(String)? onChanged, IconData prefixIcon,
    TextInputType inputType, TextEditingController controller, String? errorText,
    {String? label}) {
  return SizedBox(
    // height: AppSize.s60,
    width: AppSize.s300,
    child: TextFormField(
      controller: controller,
      style: TextStyle(
        color: ColorManager.orange,
      ),
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: ColorManager.orange),
        labelText: label,
        labelStyle: TextStyle(color: ColorManager.grey),
        errorText: errorText,
      ),
      onChanged: onChanged,
    ),
  );
}

// Toasts ::

CherryToast errorToast(String msg) {
  return CherryToast.error(
    title: Text(msg, style: TextStyle(color: ColorManager.red)),
    backgroundColor: ColorManager.whiteGrey,
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

CherryToast successToast(String msg) {
  return CherryToast.success(
    title: Text(msg, style: TextStyle(color: ColorManager.orange)),
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}
