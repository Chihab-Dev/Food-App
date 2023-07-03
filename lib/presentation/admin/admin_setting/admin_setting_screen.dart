import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:food_app/presentation/resources/styles_manager.dart';

import '../../main/base_cubit/cubit.dart';
import '../../resources/appsize.dart';
import '../../resources/color_manager.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({super.key});

  @override
  State<AdminSetting> createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        BaseCubit cubit = BaseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.adminSettings.toUpperCase()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: AppSize.s50,
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Is Store Open',
                        style: getMeduimStyle(color: ColorManager.orange),
                      ),
                      Switch.adaptive(
                        value: cubit.isStoreOpen,
                        onChanged: (value) {
                          cubit.changeIsStoreOpen();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
