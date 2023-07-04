import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/model/models.dart';
import 'appsize.dart';
import 'assets_manager.dart';
import 'font_manager.dart';

// item container

Widget itemContainer(BuildContext context, ItemObject item) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.mealDetail, arguments: item);
      },
      child: Container(
        // width: AppSize.s200,
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.ligthGrey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 4,
              offset: const Offset(4, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(AppSize.s20),
            //       image: DecorationImage(
            //         image: NetworkImage(item.image),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    // height: AppSize.s150,
                    // width: AppSize.s150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    // height: AppSize.s150,
                    // width: AppSize.s150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              item.image.isEmpty ? 'meal' : item.title,
              style: getMeduimStyle(color: ColorManager.black),
            ),
            SizedBox(
              width: AppSize.s200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      starsCalculator(item.stars),
                      (index) => Icon(
                        index < item.stars ? Icons.star : Icons.star_border,
                        color: Colors.yellowAccent[700],
                        size: AppSize.s18,
                      ),
                    ),
                  ),
                  Text(
                    "\$${item.price}",
                    style: getMeduimStyle(color: ColorManager.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

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

// Loading Screen ::

Container closedScreen() {
  return Container(
    color: ColorManager.whiteGrey.withOpacity(0.7),
    child: Center(
      child: Lottie.asset(LottieAsset.closed),
    ),
  );
}

// Loading Screen ::

Container loadingScreen() {
  return Container(
    color: ColorManager.whiteGrey.withOpacity(0.7),
    child: Center(
      child: Lottie.asset(LottieAsset.loading),
    ),
  );
}

// Error Screen ::

Container errorScreen(BuildContext context) {
  return Container(
    width: double.infinity,
    color: ColorManager.whiteGrey,
    child: Center(
      child: LottieBuilder.asset(
        LottieAsset.offline,
        width: MediaQuery.sizeOf(context).width / 2,
        animate: true,
      ),
    ),
  );
}

// empty Screen ::

Container emptyScreen() {
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

// total preparing itme calculator

int calculateTotalPreparingTime(List<Order> orders) {
  int time = 0;

  for (var i = 0; i < orders.length; i++) {
    time += orders[i].itemObject.preparationTime * orders[i].quentity;
  }

  return time;
}

// GET TIME ::

String getFormattedDateTime(DateTime dateTime) {
  String month = getMonthName(dateTime.month);
  String day = dateTime.day.toString().padLeft(2, '0');
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  return '$hour:$minute, $day-$month';
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
