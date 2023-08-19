import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';

import '../../resources/appsize.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AdminScreenView extends StatelessWidget {
  const AdminScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.whiteGrey,
        appBar: AppBar(
          title: Text(AppStrings.adminScreen.toUpperCase()),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppPadding.p8.sp),
          child: ListView(
            children: [
              item(
                context,
                AppStrings.orders,
                LottieAsset.pizzaBox,
                () {
                  Navigator.pushNamed(context, Routes.adminAllOrders);
                },
              ),
              item(
                context,
                AppStrings.allItems,
                LottieAsset.burger,
                () {
                  Navigator.pushNamed(context, Routes.adminAllItems);
                },
              ),
              item(
                context,
                AppStrings.addMeal,
                LottieAsset.addItem,
                () {
                  Navigator.pushNamed(context, Routes.adminAddNewMeal);
                },
              ),
              item(
                context,
                AppStrings.adminSettings,
                LottieAsset.setting,
                () {
                  Navigator.pushNamed(context, Routes.adminSetting);
                },
              ),
            ],
          ),
        ));
  }

  Padding item(BuildContext context, String title, String lottieAsset, Function()? onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8.sp, vertical: AppPadding.p6.sp),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: AppSize.s200.sp,
          padding:  EdgeInsets.all(AppPadding.p10.sp),
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
            borderRadius: BorderRadius.circular(AppSize.s20.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20.sp),
                    // image: const DecorationImage(
                    //   image: AssetImage(ImageAsset.box),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: LottieBuilder.asset(lottieAsset),
                ),
              ),
              // const SizedBox(height: AppSize.s10),
              Text(
                title,
                style: getlargeStyle(color: ColorManager.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
