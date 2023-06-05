import 'package:flutter/material.dart';
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
        body: ListView(
          children: [
            item(context, AppStrings.orders, LottieAsset.pizzaBox),
            item(context, AppStrings.addMeal, LottieAsset.addItem),
          ],
        ));
  }

  Padding item(BuildContext context, String title, String lottieAsset) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
      child: InkWell(
        onTap: () {
          //TODO: add it as a parametre
          Navigator.pushNamed(context, Routes.adminAllOrders);
        },
        child: Container(
          width: double.infinity,
          height: AppSize.s200,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20),
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
