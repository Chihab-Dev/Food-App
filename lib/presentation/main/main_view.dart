import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/main/base_cubit/cubit.dart';
import 'package:food_app/presentation/main/base_cubit/states.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BaseCubit.get(context);
        return Scaffold(
          body: Center(
            child: cubit.pages[cubit.currentIndex],
          ),
          bottomNavigationBar: bottomNavigationBar(cubit),
        );
      },
    );
  }

  Widget bottomNavigationBar(BaseCubit cubit) {
    return Container(
      color: ColorManager.whiteGrey.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16).copyWith(top: AppPadding.p6),
        child: GNav(
          backgroundColor: ColorManager.whiteGrey,
          color: ColorManager.grey,
          activeColor: ColorManager.whiteGrey,
          tabBackgroundColor: ColorManager.orange,
          padding: const EdgeInsets.all(AppPadding.p16),
          gap: AppSize.s10,
          onTabChange: (value) => cubit.onTap(value),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: AppStrings.home,
            ),
            GButton(
              icon: Icons.search,
              text: AppStrings.search,
            ),
            GButton(
              icon: Icons.shopping_bag_outlined,
              text: AppStrings.cart,
            ),
            GButton(
              icon: Icons.person,
              text: AppStrings.profile,
            ),
          ],
        ),
      ),
    );
  }
}
