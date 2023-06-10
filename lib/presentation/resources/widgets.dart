import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';
import '../../domain/model/models.dart';
import 'appsize.dart';
import 'assets_manager.dart';
import 'font_manager.dart';

// image File to URL

// Future<String> uploadImageAndGetUrl(File imageFile) async {
//   String fileName = imageFile.path.split('/').last;
//   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$fileName');
//   UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
//   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//   String imageUrl = await taskSnapshot.ref.getDownloadURL();
//   return imageUrl;
// }

class FirebaseStorage {}
// Form Field ::

Widget textFormField(
    TextEditingController titleTextEditingController, String label, String? error, Function(String)? function) {
  return TextFormField(
    controller: titleTextEditingController,
    style: TextStyle(color: ColorManager.orange),
    keyboardType: TextInputType.text,
    onChanged: function,
    decoration: InputDecoration(
      errorText: error,
      label: Text(
        label,
        style: getMeduimStyle(color: ColorManager.orange),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.only(
        left: AppSize.s10,
        right: AppSize.s5,
        bottom: AppSize.s20,
      ),
      labelStyle: TextStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.medium,
      ),
    ),
  );
}

Widget customFormField(BuildContext context, Function(String)? onChanged, IconData? prefixIcon, TextInputType inputType,
    TextEditingController controller, String? errorText,
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

// Loading Screen ;:

Container loadingScreen() {
  return Container(
    color: ColorManager.whiteGrey.withOpacity(0.7),
    child: Center(
      child: Lottie.asset(LottieAsset.loading),
    ),
  );
}

// Error Screen ::

Container errorScreen() {
  //TODO: add error screen
  return Container();
}

// No Orders Screen ::

Container noOrdersScreen() {
  return Container(
    color: ColorManager.whiteGrey,
    child: Center(
      child: LottieBuilder.asset(
        LottieAsset.noOrders,
        animate: true,
      ),
    ),
  );
}

// Stars calculator

int starsCalculator(int starsNum) {
  if (starsNum > 5) {
    return 5;
  } else if (starsNum < 1) {
    return 1;
  } else {
    return starsNum;
  }
}

// Num of items calculator

int calculateNumOfItems(List<Order> userOrders) {
  int numOfItems = 0;
  for (var i = 0; i < userOrders.length; i++) {
    numOfItems += userOrders[i].quentity;
  }
  return numOfItems;
}

// total price calculator

int calculateTotalPrice(List<Order> userOrders) {
  int totalPrice = 0;
  for (var i = 0; i < userOrders.length; i++) {
    totalPrice += userOrders[i].itemObject.price * userOrders[i].quentity;
  }
  return totalPrice;
}

// GET TIME ::

String getFormattedDateTime(DateTime dateTime) {
  // PADLEFT ::
  //  String string = '123';
  // String paddedString = string.padLeft(5, '0');
  // print(paddedString); // Output: 00123

  String month = getMonthName(dateTime.month);
  String day = dateTime.day.toString().padLeft(2, '0');
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  return '$month $day, $hour:$minute';
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
