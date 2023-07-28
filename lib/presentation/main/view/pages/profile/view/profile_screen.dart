import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/widgets.dart';

import '../../../../../resources/appsize.dart';
import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../../resources/styles_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        CustomerObject? customerObject = cubit.customerObject;
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: ColorManager.whiteGrey,
          appBar: AppBar(
            title: Text(
              AppStrings.profile.toUpperCase(),
              style: getMeduimStyle(color: ColorManager.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: cubit.customerObject == null
              ? emptyScreen()
              : profileView(
                  customerObject!,
                  context,
                  cubit,
                ),
        );
      },
    );
  }

  Widget profileView(CustomerObject customerObject, BuildContext context, BaseCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16, horizontal: AppPadding.p10).copyWith(bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height / 6.5),
            imageCircule(context),
            const SizedBox(height: AppSize.s20),
            nameText(customerObject),
            phoneText(customerObject),
            const SizedBox(height: AppSize.s50),
            clientInformationRow(),
            const SizedBox(height: AppSize.s50),
            listTile(AppStrings.notification, Icons.notifications_none_sharp, () {}),
            divider(),
            listTile(AppStrings.settings, Icons.settings, () {}),
            divider(),
            listTile(AppStrings.logout, Icons.logout_rounded, () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.rightSlide,
                title: AppStrings.warning,
                desc: AppStrings.warningMsg,
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  cubit.logout(context);
                },
                autoHide: const Duration(seconds: 5),
                btnOkText: AppStrings.logout,
                btnOkColor: ColorManager.green,
                btnCancelColor: ColorManager.red,
              ).show();
            }),
            // const SizedBox(height: AppSize.s50),
          ],
        ),
      ),
    );
  }

  Container clientInformationRow() {
    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              clientInformationRowItem('12', AppStrings.coupon),
              verticalDivider(),
              clientInformationRowItem('1200', AppStrings.points),
              verticalDivider(),
              clientInformationRowItem('24', AppStrings.order),
            ],
          ),
        ),
      ),
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      color: ColorManager.ligthGrey,
      thickness: 1,
    );
  }

  Column clientInformationRowItem(String num, String title) {
    return Column(
      children: [
        Text(
          num,
          style: getRegularStyle(color: ColorManager.black),
        ),
        Text(
          title,
          style: getMeduimStyle(color: ColorManager.ligthGrey),
        ),
      ],
    );
  }

  Divider divider() {
    return Divider(
      color: ColorManager.ligthGrey,
      indent: AppSize.s25,
      endIndent: AppSize.s25,
    );
  }

  ListTile listTile(String name, IconData icon, Function() fun) {
    return ListTile(
      title: Text(
        name,
        style: getMeduimStyle(color: ColorManager.black),
      ),
      tileColor: ColorManager.whiteGrey,
      leading: Icon(
        icon,
        color: ColorManager.grey,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: AppSize.s20,
        color: ColorManager.grey,
      ),
      onTap: fun,
    );
  }

  Text phoneText(CustomerObject customerObject) {
    return Text(
      customerObject.phoneNumber,
      style: getMeduimStyle(color: ColorManager.grey),
    );
  }

  Text nameText(CustomerObject customerObject) {
    return Text(
      customerObject.fullName.toUpperCase(),
      style: getRegularStyle(color: ColorManager.black),
    );
  }

  Container imageCircule(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 6.5,
      width: MediaQuery.sizeOf(context).width / 2.9,
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
        image: const DecorationImage(
          image: AssetImage(ImageAsset.profileImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppSize.s80),
      ),
      // child: const Image(
      //   image: AssetImage(ImageAsset.profileImage),
      // ),
    );
  }
}
