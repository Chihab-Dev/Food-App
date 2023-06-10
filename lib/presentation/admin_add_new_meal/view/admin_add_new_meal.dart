import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/model/models.dart';
import 'package:food_app/presentation/admin_add_new_meal/cubit/cubit.dart';
import 'package:food_app/presentation/admin_add_new_meal/cubit/states.dart';
import 'package:food_app/presentation/resources/assets_manager.dart';
import 'package:food_app/presentation/resources/routes_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../resources/appsize.dart';
import '../../resources/color_manager.dart';
import '../../resources/widgets.dart';

class AdminAddNewMeal extends StatelessWidget {
  const AdminAddNewMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewMealCubit(),
      child: BlocConsumer<AddNewMealCubit, AddNewMealStates>(
        listener: (context, state) {
          if (state is PickImageErrorState) {
            errorToast(state.error).show(context);
          }
          if (state is AddNewMealSuccessState) {
            successToast(AppStrings.addNewMealSuccess).show(context);
          }
        },
        builder: (context, state) {
          var cubit = AddNewMealCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(AppStrings.addNewMealScreen.toUpperCase()),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s12),
                    child: Column(
                      children: [
                        pickImageContainer(cubit),
                        const SizedBox(height: AppSize.s25),
                        textFormField(
                          cubit.titleController,
                          AppStrings.mealTitle,
                          cubit.nameErrorMessage,
                          (String value) {
                            cubit.isNameValidFun();
                            cubit.nameErrorMessage = cubit.nameErrorMessageFun();
                            cubit.isAllParametersValidFun();
                          },
                        ),
                        const SizedBox(height: AppSize.s25),
                        textFormField(
                          cubit.descController,
                          AppStrings.mealDescription,
                          cubit.descErrorMessage,
                          (String value) {
                            cubit.isDescValidFun();
                            cubit.descErrorMessage = cubit.descErrorMessageFun();
                            cubit.isAllParametersValidFun();
                          },
                        ),
                        const SizedBox(height: AppSize.s25),
                        pricePicker(cubit),
                        const SizedBox(height: AppSize.s25),
                        starsPicker(cubit),
                        const SizedBox(height: AppSize.s100),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar(cubit, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget pickImageContainer(AddNewMealCubit cubit) {
    return InkWell(
      onTap: () => cubit.pickImage(),
      child: cubit.image == null
          ? Container(
              width: AppSize.s200,
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
                borderRadius: BorderRadius.circular(AppSize.s50),
              ),
              child: LottieBuilder.asset(LottieAsset.imagePicker),
            )
          : Container(
              width: AppSize.s200,
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
                borderRadius: BorderRadius.circular(AppSize.s50),
              ),
              child: Image.file(cubit.image!),
            ),
    );
  }

  Widget bottomNavigationBar(AddNewMealCubit cubit, BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: ColorManager.white.withOpacity(0.7),
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
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
          child: Row(
            children: [
              orderStateContainer(
                  AppStrings.clientView,
                  cubit.isAllParametersValid
                      ? () {
                          Navigator.pushNamed(context, Routes.adminMealDetail,
                              arguments: AddNewMealObject(cubit.itemObject, cubit.image));
                        }
                      : () {
                          errorToast(AppStrings.itemNotValid).show(context);
                        }),
              orderStateContainer(
                AppStrings.addNewMeal,
                cubit.isAllParametersValid
                    ? () {
                        cubit.addNewMealItem();
                      }
                    : () {
                        cubit.nameErrorMessageFun();
                        cubit.descErrorMessageFun();
                        errorToast(AppStrings.itemNotValid).show(context);
                      },
              ),
              // orderStateContainer(
              //   AppStrings.clientView,
              //   cubit.isAllParametersValid(cubit.titleController.text, cubit.descController.text) ? () {} : null,
              // ),
              // orderStateContainer(
              //   AppStrings.addNewMeal,
              //   cubit.isParametersValid(cubit.titleController.text, cubit.descController.text)
              //       ? cubit.addNewMealItem
              //       : null,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderStateContainer(String name, Function()? function) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
        child: InkWell(
          onTap: function,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.orange,
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Center(
              child: Text(
                name,
                style: getRegularStyle(color: ColorManager.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pricePicker(AddNewMealCubit cubit) {
    return Row(
      children: [
        Text(
          AppStrings.mealPrice,
          style: getRegularStyle(color: ColorManager.orange),
        ),
        Expanded(
          child: NumberPicker(
            minValue: 5,
            maxValue: 100,
            value: cubit.price,
            onChanged: (value) {
              cubit.changePrice(value);
              cubit.isAllParametersValidFun();
            },
            selectedTextStyle: getlargeStyle(color: ColorManager.orange),
            axis: Axis.horizontal,
            itemCount: 3,
            step: 5,
          ),
        ),
      ],
    );
  }

  Widget starsPicker(AddNewMealCubit cubit) {
    return Row(
      children: [
        Text(
          AppStrings.mealStars,
          style: getRegularStyle(color: ColorManager.orange),
        ),
        Expanded(
          child: NumberPicker(
            minValue: 1,
            maxValue: 5,
            value: cubit.stars,
            onChanged: (value) {
              cubit.changeStars(value);
              cubit.isAllParametersValidFun();
            },
            selectedTextStyle: getlargeStyle(color: ColorManager.orange),
            axis: Axis.horizontal,
            itemCount: 3,
            step: 1,
          ),
        ),
      ],
    );
  }
}
